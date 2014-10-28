using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using EPiServer.Core;
using EPiServer.DataAnnotations;

namespace EPiServer.Sample.YouTubeProvider.Models
{
	/// <summary>
	/// Representing an YouTube playlist item.
	/// </summary>
	[ContentType(GUID = "0C3A1999-CFCB-4E54-9A26-E82EA789D874",
		DisplayName = "Playlist Item", AvailableInEditMode = false, GroupName = "YouTube")]
	public class YouTubePlaylistItem : YouTubeVideo
    {
    }
}