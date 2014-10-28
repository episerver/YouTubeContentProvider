using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace EPiServer.Sample.YouTubeProvider
{
	public enum YouTubeResourceType
	{
		PlaylistRoot,
		SubscriptionRoot,
		Playlist,
		PlaylistItem,
		Subscription,
		Video,
		Search,
		Unknown
	}
}