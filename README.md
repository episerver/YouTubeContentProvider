YouTube Content Provider
======================

This document describes how to create a read only content provider using the YouTube Data API (v3) to incorporate YouTube functionality such as browsing playlists and subscriptions, play movies and easily use this content in EPiServer CMS templates.

The integration also demonstrates how to use an external API using OAuth 2.0 authentication, renewal of the access token and how to save these settings in the EPiServer user interface. The integration is built as an add-on for easy installation in EPiServer as well as show how an Add-on project is designed.

Requirements and notifications
------------
The following apply when deploying the YouTube content provider to an EPiServer website.
- Requires EPiServer CMS version 7.14.1.0 or higher
- Authorization credentials to be able to use the YouTube Data API, https://developers.google.com/youtube/registering_an_application

Integration
------------
The integration consists of three main parts. The first part is the content provider who is responsible for requesting the YouTube Data API and translate YouTube resources to instances that inherit from ContentFolders or MediaData types. There is a UI component that registers a new tab in the media gadget where editors can navigate YouTube content. The last part is an initialization module responsible for creating the entry point as well as register the provider, the module also registers routes for the content. 

The integration also includes a content search provider that allows searching of YouTube videos directly in the media gadget, as well as an implementation of dynamic data store to save settings related to the integration.

Creating the content provider
------------
A custom content provider must inherit from the ContentProvider class that resides in the EPiServer.dll assembly. When creating a custom content provider it is only one the abstract method LoadContent that must be implemented, but for this example the method LoadChildrenReferenceSandTypes must be implemented as well.

<h4>LoadContent</h4>

LoadContent is the method to use to pull out one specific YouTube resource from the API and return it - an instance of an object that is implementing the IContent interface (for example YouTubeVideo).

```C#
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
					
      var subscription = _youTubeRepository.GetSubscription(
           RemoveEndingSlash(mappedItem.ExternalIdentifier.Segments[3]));
      if (subscription != null)
        return CreateYouTubeData(mappedItem, typeof(YouTubeSubscription), subscription);
      break;

    case YouTubeResourceType.Video:

      var video = _youTubeRepository.GetVideo(
           RemoveEndingSlash(mappedItem.ExternalIdentifier.Segments[3]));
      if (video != null)
        return CreateVideo(mappedItem, video);
     break;		
  }

    return CreateAndAssignIdentity(
        mappedItem, typeof(YouTubeFolder), RemoveStartingSlash(mappedItem.ExternalIdentifier.LocalPath));
}
```
This method takes a **ContentReference** and **ILanguageSelector**, in this integration, we are not dependent on language, and therefore ignores it is value.

ContentLink contains information about which item we'll get from YouTube Data API, EPiServer uses internally **ContentReference** consisting of integers and a GUID to identify content while YouTube makes use of unique strings. To keep track of the mapping the services **IdentityMappingService** is used to handles the mapping between YouTube identity and EPiServers content references.

Based on the content reference, we pick out the mapped identity that identifies the YouTube resource using the property ExternalIdentifier which is of type Uri, the structure of the URI contains information to identify the external resource, and in this integration the structure of a playlist item is as follow: **playlist/808/FLpNTbg-UP1Fpk5xBbAyMqA/FLftzDmUNtkJZF4_GvUGUsS6BYV_LQLqjN**
- The first segment identifies the resource as a playlist.
- Second segment indicates the ID of the parent node
- Third segment identifies the YouTube's playlist id
- The last and final segment identifies the playlist item id.


<h4>LoadChildrenReferencesAndTypes</h4>
LoadChildrenReferencesAndTypes is the method to pull out a list of child references and their types.

<h4>Create the default structure</h4>
Under the starting point for our content provider, we create three folders of the content type **YouTubeFolders** and this is the basis of our structure. Playlists and Subscriptions are more or less self-explanatory under these nodes the playlists and subscriptions appear.

```C#
if (EntryPoint.CompareToIgnoreWorkID(contentLink))
{
    childrenList.Add(new GetChildrenReferenceResult { ContentLink = _identityMappingService.Get(
        MappedIdentity.ConstructExternalIdentifier(ProviderKey, "Playlists"), true).ContentLink, 
        IsLeafNode = false, ModelType = typeof(YouTubeFolder) });

    childrenList.Add(new GetChildrenReferenceResult { ContentLink = _identityMappingService.Get(
        MappedIdentity.ConstructExternalIdentifier(ProviderKey, "Subscriptions"), true).ContentLink, 
        IsLeafNode = false, ModelType = typeof(YouTubeFolder) });
			
    SearchResultNode = _identityMappingService.Get(
        MappedIdentity.ConstructExternalIdentifier(ProviderKey, "Search"), true).ContentLink;
        childrenList.Add(new GetChildrenReferenceResult { ContentLink = SearchResultNode, 
        IsLeafNode = false, ModelType = typeof(YouTubeFolder) });

    return childrenList;
}
```

Under the node Search will search results for videos appear as it is not possible to find out which playlist a specific video belongs when requesting the YouTube Data API as well as the search is done on all videos, even those not belonging to the logged in YouTube account.
 

<h4>Request a list of playlists</h4>
In the same way as in method LoadContent we pick out the mapped identity that identifies the YouTube resource for a content reference. Depending on what type of YouTube resource it is, we request the different methods in the YouTube Data API to retrieve the associated resources. Below is a code snippet to retrieve playlist items for a specific playlist.

```C#
var childrenList = new List<GetChildrenReferenceResult>();
var mappedItem = _identityMappingService.Get(contentLink);
dynamic items;

switch (GetYouTubeResourceType(mappedItem.ExternalIdentifier))
{
  case YouTubeResourceType.PlaylistRoot:
  
    // Implementation to request playlists....

  break;

  case YouTubeResourceType.Playlist:

    // Request playlist items for a playlist
    items = _youTubeRepository.ListPlaylistItems(mappedItem.ExternalIdentifier.Segments[3]);

    if (items != null)
    {
      foreach (var item in items)
      {						
        var uri = MappedIdentity.ConstructExternalIdentifier(ProviderKey,
            string.Format("{0}/{1}/{2}/{3}", 
            YouTubeResourceType.Playlist.ToString().ToLower(), 
            contentLink.ID, 
            mappedItem.ExternalIdentifier.Segments[3], 
            item.id));
        
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
    Continue....
}
```

An external identifier is constructed based on the custom provider and a provider unique path. 

```C#
var uri = MappedIdentity.ConstructExternalIdentifier(ProviderKey, 
  string.Format("{0}/{1}/{2}/{3}", 
  YouTubeResourceType.Playlist.ToString().ToLower(), 
  ontentLink.ID, 
  mappedItem.ExternalIdentifier.Segments[3], 
  item.id));
```

The mapped identity gets loaded for the external identifier, passing true to create the mapping if it not exists.
```C#
var mappedChild = _identityMappingService.Get(uri, true);
```

An instance of **GetChildrenReferenceResult** is added to the children collection where it defines the ContentLink to the mapped identity, the children should be considered as a leaf node (the node will have no children) and the content type of the child.

```C#
childrenList.Add(new GetChildrenReferenceResult			
{						
  ContentLink = mappedChild.ContentLink,			 
  IsLeafNode = true, 
  ModelType = typeof(YouTubePlaylistItem)
});
```

Usually, a list of the children and their types is created in the method **LoadChildrenReferencesAndTypes**, but in this integration we receive all the data about the resource when the YouTube API is requested and we can thus create up the content instance and add it to the EPiServer cache, this increases the performance because the resource does not need to be loaded through the **LoadContent** method.

```C#
// We have all the data about the YouTube resource and creates the content 
// instance and adds it to the cache.
AddContentToCache(CreatePlaylistItem(mappedChild, item));
```

<h4>Creating YouTube content</h4>
In the code snippet above, the helper method **CreatePlaylistItem** is invoked to create an instance of the type **YouTubePlaylistItem**, in the end, the method CreateAndAssignIdentity is invoked where the actually instance is created.

```C#
private IContent CreateAndAssignIdentity(MappedIdentity mappedIdentity, Type modelType, string name)
{
  // Find parent 
  var parentLink = EntryPoint;
  if (modelType == typeof(YouTubeVideo))
    parentLink = SearchResultNode;
  else if (modelType != typeof(YouTubeFolder))
    parentLink = new ContentReference(int.Parse(RemoveEndingSlash(
      mappedIdentity.ExternalIdentifier.Segments[2])), ProviderKey);

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
  securable.GetContentSecurityDescriptor().AddEntry(
    new AccessControlEntry(EveryoneRole.RoleName, AccessLevel.Read));

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
```

This first section is where the parent node is resolved, if the model is of the type **YouTubeVideo** the parent should be the Search node created in the basic structure, if it is not of the type **YouTubeFolder** the parent is resolved from the third segment of the external identifier, otherwise is the parent the entry point of the provider.

```C#
// Find parent 
var parentLink = EntryPoint;
if (modelType == typeof(YouTubeVideo))
  parentLink = SearchResultNode;
else if (modelType != typeof(YouTubeFolder))
  parentLink = new ContentReference(int.Parse(RemoveEndingSlash(
    mappedIdentity.ExternalIdentifier.Segments[2])), ProviderKey);
```

The second part is where the instance of the content is created by invoking the method **ContentFactory.CreateContent(contentType)**, followed by setting the value of the basic properties.
```C#
var contentType = ContentTypeRepository.Load(modelType);
var content = ContentFactory.CreateContent(contentType);
content.ContentTypeID = contentType.ID;
content.ParentLink = parentLink;
content.ContentGuid = mappedIdentity.ContentGuid;
content.ContentLink = mappedIdentity.ContentLink;
content.Name = name;
```

*Instead of loading the content type by invoking ContentTypeRepository.Load(modelType) and setting the property content.ContentTypeID = contentType.ID, the overloaded method  ContentFactory.CreateContent(ContentType contentType, BuildingContext buildingContext) can be used to populate the instance with property values according to the passed in content type, default values and inherited values will be set.* 

The last part is necessary for the EPiServer interface will behave correctly.

The route segments need to be set because the entry point for the content provider is located outside the start page in EPiServer tree structure and a custom route is registered to remove the default language segment, see details in the **YouTubeProviderInitializer**.

```C#
(content as IRoutable).RouteSegment = UrlSegment.GetUrlFriendlySegment(content.Name);
```

As there is no access rights management for YouTube content we set read access for everyone.

```C#
var securable = content as IContentSecurable;
securable.GetContentSecurityDescriptor().AddEntry(
  new AccessControlEntry(EveryoneRole.RoleName, AccessLevel.Read));
```

The last two settings that must be set is the publish status to Published and Changed the date to the current date.

```C#
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
```

<h4>Creating the preview thumbnail</h4>
There are a few limitations in EPiServer editorial interface when it comes to making use of thumbnails in content listings, first requirement for EPiServer to show thumbnails the content type must implementing the interface **IBinaryStorable**, second requirement is to have a property named Thumbnail on the content type that has **ImageDescriptor** attribute specified, if this is the case, the name of the property can be added in the URL of the content type to load the automatically generated thumbnail.  **Example:** /episerver/CMS/Content/globalassets/en/alloylogo.gif/**thumbnail**
The last limitation is that the thumbnails cannot be automatically generated when the content provider is read only, we have to manually generate this when an instance of YouTubePlaylistItem or YoutubeVideo is created.

```C#
private YouTubePlaylistItem CreatePlaylistItem(MappedIdentity mappedIdentity, dynamic playlistItem)
{
  var contentMedia = CreateYouTubeData(
    mappedIdentity, typeof(YouTubePlaylistItem), playlistItem) as YouTubePlaylistItem;
    contentMedia.VideoId = playlistItem.snippet.resourceId.videoId;
    contentMedia.Thumbnail = CreateThumbnail(contentMedia);

  return contentMedia;
}

private Blob CreateThumbnail(YouTubeVideo video)
{
  // Delete previous generated blobs
  BlobFactory.Instance.Delete(video.BinaryDataContainer);

  // Download thumbnail and create the blob
  var webClient = new WebClient();
  var imageData = webClient.DownloadData(video.ThumbnailUrl);
  var thumbNailBlob = BlobFactory.Instance.CreateBlob(video.BinaryDataContainer, ".jpg");

  using (var stream = new MemoryStream(imageData))
  {
    thumbNailBlob.Write(stream);
  }
			
  // Create thumbnail
  var attribute = video.GetType().GetProperty("Thumbnail")
    .GetCustomAttribute<ImageDescriptorAttribute>();

  return _thumbnailManager.CreateImageBlob(thumbNailBlob, "Thumbnail", attribute);
}
```

First in the method we delete the blob container for the video if there is already one, the reason is that it generates a new thumbnail every time an instance of the **YoutubeVideo** is created and old pictures will remain in the blob container.

Second part downloading the video preview image, creates a new blob and writes the data.

In the last part, we generate thumbnail, the size of the thumbnail is read out from **ImageDescriptorAttribute** and the method **CreateImageBlob**(sourceBlob, property name, descriptorAttribute) is invoked, finally overwrite the blob with the thumbnail.

A drawback is that we get the menu choice **Download** for the YouTube video, the reason is that we need to implement the **IBinaryStorable** interface, it is the thumbnail image that will be downloaded. 

Extending the EPiServer user interface
------
To extend EPiServer's editorial interface and enable navigation of YouTube content, a component is created that inherits from the **ComponentDefinitionBase**, YouTube content is presented in a separate tab in the media gadget.

```C#
[Component]
public class YouTubeComponent : ComponentDefinitionBase
{
  public YouTubeComponent() : base("epi-cms.component.Media")
  {
    Categories = new [] { "content" };
    Title = "YouTube";
    Description = "List content from YouTube";
    SortOrder = 900;
    PlugInAreas = new [] { PlugInArea.AssetsDefaultGroup };
    Settings.Add(new Setting("repositoryKey", YouTubeRepositoryDescriptor.RepositoryKey));
  }
}
```

The **YouTubeRepositoryDescriptor** defined in settings are responsible for describing the content for the **YouTubeComponent**.

There are two properties that are worth highlighting, the property **Roots** defines the starting point for the component and the property **ContainedTypes** defines which data types to be displayed in the content listing.

```C#
[ServiceConfiguration(typeof(IContentRepositoryDescriptor))]
public class YouTubeRepositoryDescriptor : MediaRepositoryDescriptor
{
  private readonly IContentProviderManager _providerManager;

  public YouTubeRepositoryDescriptor(IContentProviderManager providerManager)
  {
    _providerManager = providerManager;
  }

  public static new string RepositoryKey { get { return YouTubeSettings.ProviderKey; } }

  public override string Key { get { return RepositoryKey;} }

  public override string SearchArea { get { return RepositoryKey; } }

  public override string Name { get { return YouTubeSettings.ProviderName; } }

  public override IEnumerable<ContentReference> Roots
  {
    get { return new [] { _providerManager.GetProvider(YouTubeSettings.ProviderKey).EntryPoint };}
  }

  public override IEnumerable<Type> ContainedTypes
  {
    get { return new[] { typeof(YouTubeVideo), typeof(YouTubePlaylistItem) }; }
  }
}
```

Read more about describing content in the UI http://world.episerver.com/Documentation/Items/Developers-Guide/EPiServer-CMS/75/User-interface/Describing-content-in-the-UI/

Initialize content provider
-----
When the EPiServer application starts up the content provider must be initiated, this is done in the **YouTubeProviderInitializer** module that implements **IInitializableModule** interface.

```C#
[ModuleDependency(typeof(EPiServer.Web.InitializationModule))]
public class YouTubeProviderInitializer : IInitializableModule
{
  public void Initialize(Framework.Initialization.InitializationEngine context)
  {
    // Create provider root if not exists
    var contentRepository = context.Locate.ContentRepository();
    var youTubeRoot = contentRepository.GetBySegment(
        SiteDefinition.Current.RootPage, 
        YouTubeSettings.ProviderName, 
        LanguageSelector.AutoDetect(true));

    if (youTubeRoot == null)
    {
      youTubeRoot = contentRepository.GetDefault<ContentFolder>(SiteDefinition.Current.RootPage);
      youTubeRoot.Name = YouTubeSettings.ProviderName;
      contentRepository.Save(youTubeRoot, SaveAction.Publish, AccessLevel.NoAccess);
    }

    // Register provider
    var contentProviderManager = context.Locate.Advanced.GetInstance<IContentProviderManager>();
    var configValues = new NameValueCollection { 
        { ContentProviderElement.EntryPointString, youTubeRoot.ContentLink.ToString() } };
    var provider = context.Locate.Advanced.GetInstance<YouTubeProvider>();
    provider.Initialize(YouTubeSettings.ProviderKey, configValues);
    contentProviderManager.ProviderMap.AddProvider(provider);

    // Since we have our structure outside asset root we register custom route for it
    // and remove the language segment
    RouteTable.Routes.MapContentRoute(
      name: "YouTubeMedia",
      url: "youtube/{node}/{partial}/{action}",
      defaults: new { action = "index" },
      contentRootResolver: (s) => youTubeRoot.ContentLink);

    // EPiServer UI needs the language segment
    RouteTable.Routes.MapContentRoute(
      name: "YouTubeMediaEdit",
      url: CmsHomePath + "youtube/{language}/{medianodeedit}/{partial}/{action}",
      defaults: new { action = "index" },
      contentRootResolver: (s) => youTubeRoot.ContentLink);
  }

  private static string CmsHomePath
  {
    get 
    { 
      var cmsContentPath = VirtualPathUtility.AppendTrailingSlash(
        EPiServer.Shell.Paths.ToResource("CMS", "Content"));
      return VirtualPathUtilityEx.ToAppRelative(cmsContentPath).Substring(1);
    }
  }

  public void Preload(string[] parameters)
  {
  }

  public void Uninitialize(Framework.Initialization.InitializationEngine context)
  {
  }
}
```

In the first part we validate if there is an entry point for of our content provider below the Root node with the name YouTube, if that is not the case, we create and publish our entry point.

```C#
// Create provider root if not exists
var contentRepository = context.Locate.ContentRepository();
var youTubeRoot = contentRepository.GetBySegment(
SiteDefinition.Current.RootPage, 
YouTubeSettings.ProviderName, 
LanguageSelector.AutoDetect(true));

if (youTubeRoot == null)
{
  youTubeRoot = contentRepository.GetDefault<ContentFolder>(SiteDefinition.Current.RootPage);
  youTubeRoot.Name = YouTubeSettings.ProviderName;
  contentRepository.Save(youTubeRoot, SaveAction.Publish, AccessLevel.NoAccess);
}
```

The second part is where the YouTube content provider is registered and initialized, the content reference of our entry point is passed to the provider.

```C#
// Register provider
var contentProviderManager = context.Locate.Advanced.GetInstance<IContentProviderManager>();
var configValues = new NameValueCollection { 
    {ContentProviderElement.EntryPointString, youTubeRoot.ContentLink.ToString()} };
var provider = context.Locate.Advanced.GetInstance<YouTubeProvider>();
provider.Initialize(YouTubeSettings.ProviderKey, configValues);
contentProviderManager.ProviderMap.AddProvider(provider);
```

In the last part we register our route, the reason we have to register a custom route is to get the thumbnails to work properly, otherwise it had not been necessary since we only use the partial rendering when we inserting YouTube content in our templates. 

Another reason to create a custom route is when you need to remove the language segment, in this YouTube integration there is no language management. 

The editorial interface requires a language segments and therefore a separate routes needs to be registered to get it work.

```C#
// Since we have our structure outside asset root we register custom route for it
// and remove the language segment
RouteTable.Routes.MapContentRoute(
      name: "YouTubeMedia",
      url: "youtube/{node}/{partial}/{action}",
      defaults: new { action = "index" },
      contentRootResolver: (s) => youTubeRoot.ContentLink);

// EPiServer UI needs the language segment
RouteTable.Routes.MapContentRoute(
      name: "YouTubeMediaEdit",
      url: CmsHomePath + "youtube/{language}/{medianodeedit}/{partial}/{action}",
      defaults: new { action = "index" },
      contentRootResolver: (s) => youTubeRoot.ContentLink);
```

Implementing search provider
-----
A Search Provider must be implemented to be able to search in YouTube content, this is done by a class that implements ContentProviderSearchBase and has the SearchProvider attribute, we override the method Search which performs the search against the YouTube API.

```C#
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
        var mappedIdentity =  _identityMappingService.Get(MappedIdentity.ConstructExternalIdentifier(
  	        _youTubeProvider.ProviderKey, 
            string.Format("video/{0}/{1}", 
            _youTubeProvider.SearchResultNode.ID, 
            item.id.videoId)), true);

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
```

There are a few things you should note, when the search result are retrieved from the YouTube API we first filter out all the hits that are not of type video, after we create the mapped identity and adds this to the search result for the provider.

```C#
foreach (var item in _youTubeRepository.Search(query.SearchQuery))
{
  if (item.id.kind == "youtube#video")
  {
    var mappedIdentity =  _identityMappingService.Get(MappedIdentity.ConstructExternalIdentifier(
  	    _youTubeProvider.ProviderKey, 
        string.Format("video/{0}/{1}", 
        _youTubeProvider.SearchResultNode.ID, 
        item.id.videoId)), true);

     var youTubeSearchResult = _youTubeProvider.CreateSearchResult(mappedIdentity, item);
     searchResults.Add(CreateSearchResult(youTubeSearchResult));
     _youTubeProvider.SearchResult.Add(youTubeSearchResult);
   }
 }
```
*As there are limitations in EPiServers editorial interface when it comes to present search results, we have chosen to present the results in a separate node, this means that for each search hit, it creates a mapped identity and it could result in filling up the mapping table with a lot of unnecessary items that are never used for the site.* 

To limit the search provider to apply only for the YouTube content provider, it is important to set the property Area to the same name as the content provider.

```C#
public override string Area { get { return YouTubeSettings.ProviderKey; } }
```

Summary
-----
The rest of the project's features are fairly self-explanatory, an OAuth 2.0 implementation that authenticates against YouTube API and renews the access token before it expires. An example of how to use EPiServer Dynamic Data Store to store settings for integration and that the entire integration is packaged as an add-on for easy installation into EPiServer.


License
-------

This software is licensed under the Apache 2 license, quoted below.

Copyright 2009-2012 Shay Banon and ElasticSearch <http://www.elasticsearch.org>

Licensed under the Apache License, Version 2.0 (the "License"); you may not
use this file except in compliance with the License. You may obtain a copy of
the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS, WITHOUT
WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the
License for the specific language governing permissions and limitations under
the License.
