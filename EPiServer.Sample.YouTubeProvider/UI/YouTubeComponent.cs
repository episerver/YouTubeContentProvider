using EPiServer.Shell;
using EPiServer.Shell.ViewComposition;

namespace EPiServer.Sample.YouTubeProvider.UI
{
    /// <summary>
    /// Component that provides a YouTube integration.
    /// </summary>
    [Component]
    public class YouTubeComponent : ComponentDefinitionBase
    {
        public YouTubeComponent()
			: base("epi-cms.component.Media")
        {
            Categories = new [] { "content" };
            Title = "YouTube";
            Description = "List content from YouTube";
            SortOrder = 900;
			PlugInAreas = new [] { PlugInArea.AssetsDefaultGroup };
			Settings.Add(new Setting("repositoryKey", YouTubeRepositoryDescriptor.RepositoryKey));
        }
    }
}