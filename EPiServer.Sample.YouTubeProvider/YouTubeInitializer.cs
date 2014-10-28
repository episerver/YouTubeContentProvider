using System.Collections.Specialized;
using System.Linq;
using EPiServer.Configuration;
using EPiServer.Core;
using EPiServer.DataAbstraction;
using EPiServer.DataAbstraction.RuntimeModel;
using EPiServer.Framework;
using EPiServer.ServiceLocation;
using EPiServer.Sample.YouTubeProvider.Models;
using EPiServer.Web;
using EPiServer.Web.Routing;
using EPiServer.DataAccess;
using EPiServer.Security;
using System.Web.Routing;
using System.Web;

namespace EPiServer.Sample.YouTubeProvider
{
    [ModuleDependency(typeof(EPiServer.Web.InitializationModule))]
    public class YouTubeProviderInitializer : IInitializableModule
    {
        public void Initialize(Framework.Initialization.InitializationEngine context)
        {
			// Create provider root if not exists
			var contentRepository = context.Locate.ContentRepository();
			var youTubeRoot = contentRepository.GetBySegment(SiteDefinition.Current.RootPage, YouTubeSettings.ProviderName, LanguageSelector.AutoDetect(true));
			if (youTubeRoot == null)
			{
				youTubeRoot = contentRepository.GetDefault<ContentFolder>(SiteDefinition.Current.RootPage);
				youTubeRoot.Name = YouTubeSettings.ProviderName;
				contentRepository.Save(youTubeRoot, SaveAction.Publish, AccessLevel.NoAccess);
			}

            // Register provider
			var contentProviderManager = context.Locate.Advanced.GetInstance<IContentProviderManager>();
			var configValues = new NameValueCollection { {ContentProviderElement.EntryPointString, youTubeRoot.ContentLink.ToString()} };
	        var provider = context.Locate.Advanced.GetInstance<YouTubeProvider>();
			provider.Initialize(YouTubeSettings.ProviderKey, configValues);
			contentProviderManager.ProviderMap.AddProvider(provider);

			// Since we have our structure outside asset root we registera custom route for it
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
				var cmsContentPath = VirtualPathUtility.AppendTrailingSlash(EPiServer.Shell.Paths.ToResource("CMS", "Content"));
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
}