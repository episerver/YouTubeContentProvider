using System;
using System.Collections.Generic;
using System.Linq;
using EPiServer.Core;
using EPiServer.ServiceLocation;
using EPiServer.Shell;
using EPiServer.Sample.YouTubeProvider.Models;
using EPiServer.Cms.Shell.UI.UIDescriptors;
using EPiServer.Sample;

namespace EPiServer.Sample.YouTubeProvider.UI
{
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
			get { return new[] { _providerManager.GetProvider(YouTubeSettings.ProviderKey).EntryPoint }; }
		}

		public override IEnumerable<Type> ContainedTypes
		{
			get { return new[] { typeof(YouTubeVideo), typeof(YouTubePlaylistItem) }; }
		}
    }
}