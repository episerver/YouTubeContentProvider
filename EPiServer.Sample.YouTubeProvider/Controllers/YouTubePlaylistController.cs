using System.Web.Mvc;
using EPiServer.Sample.YouTubeProvider.Models;
using EPiServer.Sample.YouTubeProvider.Models.ViewModels;
using EPiServer.Shell;
using EPiServer.Web.Mvc;

namespace EPiServer.Sample.YouTubeProvider.Controllers
{
	public class YouTubePlaylistController : PartialContentController<YouTubePlaylist>
	{
		private readonly IContentLoader _contentLoader;

		public YouTubePlaylistController(IContentLoader contentLoader)
		{
			_contentLoader = contentLoader;
		}

		public override ActionResult Index(YouTubePlaylist currentContent)
		{
			var model = new YouTubePlaylistModel
			{
				Playlist = currentContent,
				PlaylistItems = _contentLoader.GetChildren<YouTubePlaylistItem>(currentContent.ContentLink)
			};

			return PartialView(Paths.ToResource(GetType(), "Views/Playlist.cshtml"), model);
		}
	}
}