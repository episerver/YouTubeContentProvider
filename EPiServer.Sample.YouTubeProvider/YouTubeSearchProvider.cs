using EPiServer.Cms.Shell.Search;
using EPiServer.Core;
using EPiServer.DataAbstraction;
using EPiServer.Framework.Localization;
using EPiServer.Sample.YouTubeProvider.Models;
using EPiServer.Sample.YouTubeProvider.UI;
using EPiServer.Shell.Search;
using EPiServer.Web;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace EPiServer.Sample.YouTubeProvider
{
	[SearchProvider]
	public class YouTubeSearchProvider : ContentSearchProviderBase<YouTubeVideo, ContentType>
	{
		private readonly YouTubeRepository _youTubeRepository;
		private readonly YouTubeProvider _youTubeProvider;
		private readonly IdentityMappingService _identityMappingService;

		public YouTubeSearchProvider(LocalizationService localizationService, 
			SiteDefinitionResolver siteDefinitionResolver, 
			IContentTypeRepository contentTypeRepository,
			IContentProviderManager contentProviderManager, 
			YouTubeRepository youTubeRepository,
			IdentityMappingService identityMappingService)
			: base(localizationService, siteDefinitionResolver, contentTypeRepository)
		{
			_youTubeRepository = youTubeRepository;
			_identityMappingService = identityMappingService;

			_youTubeProvider = contentProviderManager.GetProvider(YouTubeSettings.ProviderKey) as YouTubeProvider;
			
		}

		public override IEnumerable<SearchResult> Search(Query query)
		{
			var searchResults = new List<SearchResult>();
			
			// Clear previous search results
			_youTubeProvider.SearchResult.Clear();

			foreach (var item in _youTubeRepository.Search(query.SearchQuery))
			{
				if (item.id.kind == "youtube#video")
				{
					var mappedIdentity =  _identityMappingService.Get(MappedIdentity.ConstructExternalIdentifier(_youTubeProvider.ProviderKey, string.Format("video/{0}/{1}", _youTubeProvider.SearchResultNode.ID, item.id.videoId)), true);
					var youTubeSearchResult = _youTubeProvider.CreateSearchResult(mappedIdentity, item);
					searchResults.Add(CreateSearchResult(youTubeSearchResult));
					_youTubeProvider.SearchResult.Add(youTubeSearchResult);
				}
			}

			// Clear child items from the search node
			DataFactoryCache.RemoveListing(_youTubeProvider.SearchResultNode);

			return searchResults;
		}

		public override string Area { get { return YouTubeSettings.ProviderKey; } }

		public override string Category { get { return YouTubeSettings.ProviderName; } }

		protected override string IconCssClass { get { return "epi-resourceIcon epi-resourceIcon-block"; } }
	}

}