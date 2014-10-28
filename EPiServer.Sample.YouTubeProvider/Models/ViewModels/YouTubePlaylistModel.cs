using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace EPiServer.Sample.YouTubeProvider.Models.ViewModels
{
	public class YouTubePlaylistModel
	{
		public YouTubePlaylist Playlist { get; set; } 
		public IEnumerable<YouTubePlaylistItem> PlaylistItems { get; set; }
	}
}