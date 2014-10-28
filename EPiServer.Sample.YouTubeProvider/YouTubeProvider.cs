using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Reflection;
using EPiServer.Core;
using EPiServer.DataAbstraction;
using EPiServer.DataAnnotations;
using EPiServer.Framework.Blobs;
using EPiServer.ServiceLocation;
using EPiServer.Web;
using EPiServer.Sample.YouTubeProvider.Models;
using EPiServer.Web.Routing;
using EPiServer.Security;
using System.Web;
using System.Web.Caching;
using System.IO;

namespace EPiServer.Sample.YouTubeProvider
{
	/// <summary>
	/// Content provider to include YouTube content.
	/// </summary>
	public class YouTubeProvider : ContentProvider
	{
		#region Fields

		private readonly ServiceAccessor<HttpContextBase> _httpContextBase; 
		private readonly IdentityMappingService _identityMappingService;
		private readonly YouTubeRepository _youTubeRepository;
		private readonly ThumbnailManager _thumbnailManager;

		#endregion

		#region Ctor

		public YouTubeProvider(
			ServiceAccessor<HttpContextBase> httpContextBase,
			IdentityMappingService identityMappingService, 
			YouTubeRepository youTubeRepository,
			ThumbnailManager thumbnailManager)
        {
			_httpContextBase = httpContextBase;
            _identityMappingService = identityMappingService;
			_youTubeRepository = youTubeRepository;
			_thumbnailManager = thumbnailManager;
        }

		#endregion

        #region ContentProvider

		protected override IContent LoadContent(ContentReference contentLink, ILanguageSelector languageSelector)
		{
			var mappedItem = _identityMappingService.Get(contentLink);
			if (mappedItem == null) return null;

			switch (GetYouTubeResourceType(mappedItem.ExternalIdentifier))
			{
				case YouTubeResourceType.Playlist:
					
					var playlist = _youTubeRepository.GetPlaylist(mappedItem.ExternalIdentifier.Segments[3]);
					if (playlist != null)
						return CreateYouTubeData(mappedItem, typeof(YouTubePlaylist), playlist);
					break;

				case YouTubeResourceType.PlaylistItem:
					
					var playlistItem = _youTubeRepository.GetPlaylistItem(mappedItem.ExternalIdentifier.Segments[4]);
					if (playlistItem != null)
						return CreatePlaylistItem(mappedItem, playlistItem);
					break;

				case YouTubeResourceType.Subscription:
					
					var subscription = _youTubeRepository.GetSubscription(RemoveEndingSlash(mappedItem.ExternalIdentifier.Segments[3]));
					if (subscription != null)
						return CreateYouTubeData(mappedItem, typeof(YouTubeSubscription), subscription);
					break;

				case YouTubeResourceType.Video:

					var video = _youTubeRepository.GetVideo(RemoveEndingSlash(mappedItem.ExternalIdentifier.Segments[3]));
					if (video != null)
						return CreateVideo(mappedItem, video);
					break;		
			}

			return CreateAndAssignIdentity(mappedItem, typeof(YouTubeFolder), RemoveStartingSlash(mappedItem.ExternalIdentifier.LocalPath));
		}

		protected override IList<GetChildrenReferenceResult> LoadChildrenReferencesAndTypes(ContentReference contentLink, string languageID, out bool languageSpecific)
		{
			languageSpecific = false;
			var childrenList = new List<GetChildrenReferenceResult>();

			// Add Playlists, Subscriptions and Search as default nodes
			if (EntryPoint.CompareToIgnoreWorkID(contentLink))
			{
				childrenList.Add(new GetChildrenReferenceResult { ContentLink = _identityMappingService.Get(MappedIdentity.ConstructExternalIdentifier(ProviderKey, "Playlists"), true).ContentLink, IsLeafNode = false, ModelType = typeof(YouTubeFolder) });
				childrenList.Add(new GetChildrenReferenceResult { ContentLink = _identityMappingService.Get(MappedIdentity.ConstructExternalIdentifier(ProviderKey, "Subscriptions"), true).ContentLink, IsLeafNode = false, ModelType = typeof(YouTubeFolder) });
				
				SearchResultNode = _identityMappingService.Get(MappedIdentity.ConstructExternalIdentifier(ProviderKey, "Search"), true).ContentLink;
				childrenList.Add(new GetChildrenReferenceResult { ContentLink = SearchResultNode, IsLeafNode = false, ModelType = typeof(YouTubeFolder) });

				return childrenList;
			}

			var mappedItem = _identityMappingService.Get(contentLink);
			dynamic items;

			switch (GetYouTubeResourceType(mappedItem.ExternalIdentifier))
			{
				case YouTubeResourceType.PlaylistRoot:

					items = _youTubeRepository.ListPlaylists();
					if (items != null)
					{
						foreach (var item in items)
						{
							var uri = MappedIdentity.ConstructExternalIdentifier(ProviderKey,
								string.Format("{0}/{1}/{2}", YouTubeResourceType.Playlist.ToString().ToLower(), contentLink.ID, item.id));
							var mappedChild = _identityMappingService.Get(uri, true);
							childrenList.Add(new GetChildrenReferenceResult
							{
								ContentLink = mappedChild.ContentLink,
								IsLeafNode = false,
								ModelType = typeof(YouTubePlaylist)
							});

							// We have all the data about the YouTube resource and creates the content instance and adds it to the cache.
							AddContentToCache(CreateYouTubeData(mappedChild, typeof(YouTubePlaylist), item));
						}
					}
					break;

				case YouTubeResourceType.Playlist:

					items = _youTubeRepository.ListPlaylistItems(mappedItem.ExternalIdentifier.Segments[3]);
					if (items != null)
					{
						foreach (var item in items)
						{
							var uri = MappedIdentity.ConstructExternalIdentifier(ProviderKey,
								string.Format("{0}/{1}/{2}/{3}", YouTubeResourceType.Playlist.ToString().ToLower(), contentLink.ID,
									mappedItem.ExternalIdentifier.Segments[3], item.id));
							var mappedChild = _identityMappingService.Get(uri, true);
							childrenList.Add(new GetChildrenReferenceResult
							{
								ContentLink = mappedChild.ContentLink,
								IsLeafNode = true,
								ModelType = typeof(YouTubePlaylistItem)
							});

							// We have all the data about the YouTube resource and creates the content instance and adds it to the cache.
							AddContentToCache(CreatePlaylistItem(mappedChild, item));
						}
					}
					break;

				case YouTubeResourceType.SubscriptionRoot:

					items = _youTubeRepository.ListSubscriptions();
					if (items != null)
					{
						foreach (var item in items)
						{
							var uri = MappedIdentity.ConstructExternalIdentifier(ProviderKey,
								string.Format("{0}/{1}/{2}/{3}", YouTubeResourceType.Subscription.ToString().ToLower(), contentLink.ID, item.id,
									item.snippet.resourceId.channelId));
							var mappedChild = _identityMappingService.Get(uri, true);
							childrenList.Add(new GetChildrenReferenceResult
							{
								ContentLink = mappedChild.ContentLink,
								IsLeafNode = false,
								ModelType = typeof(YouTubeSubscription)
							});

							// We have all the data about the YouTube resource and creates the content instance and adds it to the cache.
							AddContentToCache(CreateYouTubeData(mappedChild, typeof(YouTubeSubscription), item));
						}
					}
					break;

				case YouTubeResourceType.Subscription:

					items = _youTubeRepository.ListPlaylists(mappedItem.ExternalIdentifier.Segments[4]);
					if (items != null)
					{
						foreach (var item in items)
						{
							var uri = MappedIdentity.ConstructExternalIdentifier(ProviderKey,
								string.Format("{0}/{1}/{2}", YouTubeResourceType.Playlist.ToString().ToLower(), contentLink.ID, item.id));
							var mappedChild = _identityMappingService.Get(uri, true);
							childrenList.Add(new GetChildrenReferenceResult
							{
								ContentLink = mappedChild.ContentLink,
								IsLeafNode = false,
								ModelType = typeof(YouTubePlaylist)
							});

							// We have all the data about the YouTube resource and creates the content instance and adds it to the cache.
							AddContentToCache(CreateYouTubeData(mappedChild, typeof(YouTubePlaylist), item));
						}
					}
			break;

				case YouTubeResourceType.Search:

					childrenList.AddRange(SearchResult.Select(item => new GetChildrenReferenceResult() {ContentLink = item.ContentLink, IsLeafNode = true, ModelType = typeof(YouTubeVideo)}));

					break;
			}

			return childrenList;
		}

		
        #endregion

		#region YouTube

		private IContent CreateYouTubeData(MappedIdentity mappedIdentity, Type modelType, dynamic youTubeData)
		{
			var content = CreateAndAssignIdentity(mappedIdentity, modelType, youTubeData.snippet.title);
			content.ItemId = youTubeData.id;
			content.ChannelId = youTubeData.snippet.channelId;
			content.ChannelTitle = youTubeData.snippet.channelTitle;
			content.Description = youTubeData.snippet.description;
			content.Published = DateTime.Parse(youTubeData.snippet.publishedAt);
			content.ThumbnailUrl = youTubeData.snippet.thumbnails.high.url;
			return content;
		}

		private YouTubePlaylistItem CreatePlaylistItem(MappedIdentity mappedIdentity, dynamic playlistItem)
		{
			var contentMedia = CreateYouTubeData(mappedIdentity, typeof(YouTubePlaylistItem), playlistItem) as YouTubePlaylistItem;
			contentMedia.VideoId = playlistItem.snippet.resourceId.videoId;
			contentMedia.Thumbnail = CreateThumbnail(contentMedia);
			return contentMedia;
		}

		private YouTubeVideo CreateVideo(MappedIdentity mappedIdentity, dynamic video)
		{
			var contentMedia = CreateYouTubeData(mappedIdentity, typeof(YouTubeVideo), video) as YouTubeVideo;
			contentMedia.VideoId = video.id;
			contentMedia.Thumbnail = CreateThumbnail(contentMedia);
			return contentMedia;
		}

		public YouTubeVideo CreateSearchResult(MappedIdentity mappedIdentity, dynamic youTubeData)
		{
			var content = CreateAndAssignIdentity(mappedIdentity, typeof(YouTubeVideo), youTubeData.snippet.title);
			content.VideoId = youTubeData.id.videoId;
			content.ItemId = youTubeData.id.videoId;
			content.ChannelId = youTubeData.snippet.channelId;
			content.ChannelTitle = youTubeData.snippet.channelTitle;
			content.Description = youTubeData.snippet.description;
			content.Published = DateTime.Parse(youTubeData.snippet.publishedAt);
			content.ThumbnailUrl = youTubeData.snippet.thumbnails.high.url;

			return content;
		}

		private IContent CreateAndAssignIdentity(MappedIdentity mappedIdentity, Type modelType, string name)
		{
			// Find parent 
			var parentLink = EntryPoint;
			if (modelType == typeof(YouTubeVideo))
				parentLink = SearchResultNode;
			else if (modelType != typeof(YouTubeFolder))
				parentLink = new ContentReference(int.Parse(RemoveEndingSlash(mappedIdentity.ExternalIdentifier.Segments[2])), ProviderKey);

			// Set content type and content type Id.
			var contentType = ContentTypeRepository.Load(modelType);
			var content = ContentFactory.CreateContent(contentType);
			content.ContentTypeID = contentType.ID;
			content.ParentLink = parentLink;
			content.ContentGuid = mappedIdentity.ContentGuid;
			content.ContentLink = mappedIdentity.ContentLink;
			content.Name = name;
			(content as IRoutable).RouteSegment = UrlSegment.GetUrlFriendlySegment(content.Name);

			var securable = content as IContentSecurable;
			securable.GetContentSecurityDescriptor().AddEntry(new AccessControlEntry(EveryoneRole.RoleName, AccessLevel.Read));

			var versionable = content as IVersionable;
			if (versionable != null)
			{
				versionable.Status = VersionStatus.Published;
			}

			var changeTrackable = content as IChangeTrackable;
			if (changeTrackable != null)
			{
				changeTrackable.Changed = DateTime.Now;
			}

			return content;
		}

		/// <summary>
		/// The node representing the searh result.
		/// </summary>
		public ContentReference SearchResultNode { get; set; }

		/// <summary>
		/// Collection containing the search result.
		/// </summary>
		public List<YouTubeVideo> SearchResult
		{
			get
			{
				var httpContextBase = _httpContextBase();
				string cacheKey = string.Format("YouTubeProvider:SearchResult:{0}", httpContextBase.User.Identity.Name);
				if (httpContextBase.Cache[cacheKey] as List<YouTubeVideo> == null)
				{
					httpContextBase.Cache.Insert(cacheKey, new List<YouTubeVideo>(), null, Cache.NoAbsoluteExpiration, new TimeSpan(0, 20, 0));
				}
				return httpContextBase.Cache[cacheKey] as List<YouTubeVideo>;
			}
		}

		public virtual void ClearCacheAndSettings()
		{
			ClearProviderPagesFromCache();
			_youTubeRepository.Settings.CurrentSettings = null;
		}

		#endregion

		#region Helpers

		private string RemoveStartingSlash(string virtualPath)
		{
			return !String.IsNullOrEmpty(virtualPath) && virtualPath[0] == '/' ? virtualPath.Substring(1) : virtualPath;
		}

		private string RemoveEndingSlash(string virtualPath)
		{
			return !String.IsNullOrEmpty(virtualPath) && virtualPath[virtualPath.Length - 1] == '/' ? virtualPath.Substring(0, virtualPath.Length - 1) : virtualPath;
		}

		private YouTubeResourceType GetYouTubeResourceType(Uri externalIdentifier)
		{
			if (ValidateSegment(externalIdentifier.Segments, 4, "playlist/"))
				return YouTubeResourceType.Playlist;
			if (ValidateSegment(externalIdentifier.Segments, 5, "playlist/"))
				return YouTubeResourceType.PlaylistItem;
			if (ValidateSegment(externalIdentifier.Segments, 5, "subscription/"))
				return YouTubeResourceType.Subscription;
			if (ValidateSegment(externalIdentifier.Segments, 4, "video/"))
				return YouTubeResourceType.Video;
			if (ValidateSegment(externalIdentifier.Segments, 2 , "playlists"))
				return YouTubeResourceType.PlaylistRoot;
			if (ValidateSegment(externalIdentifier.Segments, 2, "subscriptions"))
				return YouTubeResourceType.SubscriptionRoot;
			if (ValidateSegment(externalIdentifier.Segments, 2, "search"))
				return YouTubeResourceType.Search;

			return YouTubeResourceType.Unknown;
		}

		private bool ValidateSegment(string[] segment, int count, string identity)
		{
			return segment.Length == count && string.Equals(segment[1], identity, StringComparison.OrdinalIgnoreCase);
		}

		private Blob CreateThumbnail(YouTubeVideo video)
		{
			// Delete previous generated blobs
			BlobFactory.Instance.Delete(video.BinaryDataContainer);

			// Download thumbnail and creat blob
			var webClient = new WebClient();
			var imageData = webClient.DownloadData(video.ThumbnailUrl);
			var thumbNailBlob = BlobFactory.Instance.CreateBlob(video.BinaryDataContainer, ".jpg");
			using (var stream = new MemoryStream(imageData))
			{
				thumbNailBlob.Write(stream);
			}
			
			// Create thumbnail
			var attribute = video.GetType().GetProperty("Thumbnail").GetCustomAttribute<ImageDescriptorAttribute>();
			return _thumbnailManager.CreateImageBlob(thumbNailBlob, "Thumbnail", attribute);
		}

        #endregion
    }
}