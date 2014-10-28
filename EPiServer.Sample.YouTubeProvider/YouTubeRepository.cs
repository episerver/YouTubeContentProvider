using EPiServer.ServiceLocation;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Text;
using System.Web;
using System.Web.Helpers;

namespace EPiServer.Sample.YouTubeProvider
{
	[ServiceConfiguration(typeof(YouTubeRepository))]
	public class YouTubeRepository
	{
		private readonly YouTubeSettingsRepository _settingsRepository;

		public YouTubeRepository(YouTubeSettingsRepository settingsRepository)
		{
			_settingsRepository = settingsRepository;
		}

		#region Playlist

		/// <summary>
		/// List playlists for the signed in user.
		/// </summary>
		/// <returns>Returns a list of playlists.</returns>
		public dynamic ListPlaylists()
		{
			if (!_settingsRepository.ValidateAccessToken())
				return null;

			var jsonResult =
				GetJson(string.Format("{0}playlists?part=id%2Csnippet&mine=true&access_token={1}",
				YouTubeSettings.BaseApi, _settingsRepository.CurrentSettings.AccessToken));

			return jsonResult.items;
		}

		/// <summary>
		/// List playlists for a channel.
		/// </summary>
		/// <param name="channelId">The channel id.</param>
		/// <returns>Returns a list of playlist for the given channel id.</returns>
		public dynamic ListPlaylists(string channelId)
		{
			if (!_settingsRepository.ValidateAccessToken())
				return null;

			var jsonResult =
				GetJson(string.Format("{0}playlists?part=id%2Csnippet&channelId={2}&access_token={1}",
				YouTubeSettings.BaseApi, _settingsRepository.CurrentSettings.AccessToken, channelId));

			return jsonResult.items;
		}

		/// <summary>
		/// Gets a single playlist.
		/// </summary>
		/// <param name="playlistId">The playlist id.</param>
		/// <returns>Returns a playlist for the given id.</returns>
		public dynamic GetPlaylist(string playlistId)
		{
			if (!_settingsRepository.ValidateAccessToken())
				return null;

			var jsonResult =
						GetJson(string.Format("{0}playlists?part=id%2Csnippet&id={2}&access_token={1}",
						YouTubeSettings.BaseApi, _settingsRepository.CurrentSettings.AccessToken, playlistId));

			return ((DynamicJsonArray)jsonResult.items).FirstOrDefault<dynamic>();
		}

		/// <summary>
		/// List public playlist items for a playlist.
		/// </summary>
		/// <param name="playlistId">The paylist id.</param>
		/// <returns>Returns a list of public playlist items for the given playlist id.</returns>
		public dynamic ListPlaylistItems(string playlistId)
		{
			if (!_settingsRepository.ValidateAccessToken())
				return null;

			var jsonResult =
					GetJson(string.Format("{0}playlistItems?part=id%2Csnippet%2Cstatus&playlistId={1}&access_token={2}&maxResults=50",
					YouTubeSettings.BaseApi,
					playlistId,
					_settingsRepository.CurrentSettings.AccessToken));

			return ((DynamicJsonArray) jsonResult.items).Where<dynamic>(i => i.status.privacyStatus == "public");
		}

		/// <summary>
		/// Gets a single playlist item.
		/// </summary>
		/// <param name="playlistItemId">The playlist item id.</param>
		/// <returns>Returns a playlist item with the given playlist id.</returns>
		public dynamic GetPlaylistItem(string playlistItemId)
		{
			if (!_settingsRepository.ValidateAccessToken())
				return null;

			var jsonResult =
						GetJson(string.Format("{0}playlistItems?part=id%2Csnippet&id={1}&access_token={2}",
						YouTubeSettings.BaseApi,
						playlistItemId,
						_settingsRepository.CurrentSettings.AccessToken));

			return ((DynamicJsonArray)jsonResult.items).FirstOrDefault<dynamic>();
		}

		#endregion

		#region Channel

		/// <summary>
		/// List channels for the signed in user.
		/// </summary>
		/// <returns>Returns a list of all channels.</returns>
		public dynamic ListChannels()
		{
			if (!_settingsRepository.ValidateAccessToken())
				return null;

			var jsonResult =
				GetJson(string.Format("{0}channels?part=id%2Csnippet&mine=true&access_token={1}",
				YouTubeSettings.BaseApi, _settingsRepository.CurrentSettings.AccessToken));

			return jsonResult.items;
		}

		/// <summary>
		/// Gets a single channel.
		/// </summary>
		/// <param name="channelId">The channel id.</param>
		/// <returns>Returns a channel for the given channel id.</returns>
		public dynamic GetChannel(string channelId)
		{
			if (!_settingsRepository.ValidateAccessToken())
				return null;

			var jsonResult =
						GetJson(string.Format("{0}channels?part=id%2Csnippet&id={2}&access_token={1}",
						YouTubeSettings.BaseApi, _settingsRepository.CurrentSettings.AccessToken, channelId));

			return ((DynamicJsonArray)jsonResult.items).FirstOrDefault<dynamic>();
		}

		#endregion

		#region Subscription

		/// <summary>
		/// List subscriptions for the signed in user.
		/// </summary>
		/// <returns>Returns a list of subscriptions for the signed in user.</returns>
		public dynamic ListSubscriptions()
		{
			if (!_settingsRepository.ValidateAccessToken())
				return null;

			var jsonResult =
				GetJson(string.Format("{0}subscriptions?part=id%2Csnippet&mine=true&access_token={1}",
				YouTubeSettings.BaseApi, _settingsRepository.CurrentSettings.AccessToken));

			return jsonResult.items;
		}

		/// <summary>
		/// List subscriptions for a channel.
		/// </summary>
		/// <param name="channelId">The channel id.</param>
		/// <returns>Returns a list of subscriptions for the given channel id.</returns>
		public dynamic ListSubscriptions(string channelId)
		{
			if (!_settingsRepository.ValidateAccessToken())
				return null;

			var jsonResult =
				GetJson(string.Format("{0}subscriptions?part=id%2Csnippet&channelId={2}&access_token={1}",
				YouTubeSettings.BaseApi, _settingsRepository.CurrentSettings.AccessToken, channelId));

			return jsonResult.items;
		}

		public dynamic GetSubscription(string subscriptionId)
		{
			if (!_settingsRepository.ValidateAccessToken())
				return null;

			var jsonResult =
						GetJson(string.Format("{0}subscriptions?part=id%2Csnippet&id={2}&access_token={1}",
						YouTubeSettings.BaseApi, _settingsRepository.CurrentSettings.AccessToken, subscriptionId));

			return ((DynamicJsonArray)jsonResult.items).FirstOrDefault<dynamic>();
		}

		#endregion

		#region Video

		public dynamic GetVideo(string videoId)
		{
			if (!_settingsRepository.ValidateAccessToken())
				return null;

			var jsonResult =
						GetJson(string.Format("{0}videos?part=id%2Csnippet&id={1}&access_token={2}",
						YouTubeSettings.BaseApi,
						videoId,
						_settingsRepository.CurrentSettings.AccessToken));

			return ((DynamicJsonArray)jsonResult.items).FirstOrDefault<dynamic>();
		}

		public dynamic Search(string query)
		{
			if (!_settingsRepository.ValidateAccessToken())
				return null;

			var jsonResult =
				//GetJson(string.Format("{0}search?part=id%2Csnippet&forMine=true&q={2}&access_token={1}&type=video",
				GetJson(string.Format("{0}search?part=id%2Csnippet&q={2}&access_token={1}&type=video",
				YouTubeSettings.BaseApi, _settingsRepository.CurrentSettings.AccessToken, query));

			return jsonResult.items;
		}

		#endregion

		#region Helpers

		private dynamic GetJson(string url)
		{
			var webClient = new WebClient();
			webClient.Encoding = Encoding.UTF8;
			var stringResult = webClient.DownloadString(url);
			return Json.Decode(stringResult);
		}


		#endregion

		public virtual YouTubeSettingsRepository Settings { get { return _settingsRepository; } }
	}
}