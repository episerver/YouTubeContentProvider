using System;
using EPiServer.Core;
using EPiServer.Sample.YouTubeProvider.Models;
using EPiServer.ServiceLocation;
using EPiServer.Web;

namespace EPiServer.Sample.YouTubeProvider.Blocks
{
	public partial class PlaylistBlock : ContentControlBase<YouTubePlaylist>
	{
		protected override void OnLoad(EventArgs e)
		{
			var contentLoader = ServiceLocator.Current.GetInstance<IContentLoader>();

			RepeaterItems.DataSource = contentLoader.GetChildren<YouTubePlaylistItem>(CurrentData.ContentLink);
			RepeaterItems.DataBind();
		}
	}
}