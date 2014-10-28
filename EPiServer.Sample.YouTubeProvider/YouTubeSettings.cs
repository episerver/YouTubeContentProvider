using System;
using EPiServer.Data;
using EPiServer.Data.Dynamic;

namespace EPiServer.Sample.YouTubeProvider
{
    [EPiServerDataStore(AutomaticallyRemapStore = true, AutomaticallyCreateStore = true)]
    public class YouTubeSettings
    {
        public const string BaseApi = "https://www.googleapis.com/youtube/v3/";
		public const string Oauth2Url = "https://accounts.google.com/o/oauth2/token";
		public const string ProviderKey = "youtube";
		public const string ProviderName = "YouTube";

        public Identity Id { get; set; }

        public string ClientId { get; set; }

        public string ClientSecret { get; set; }

        public string AccessToken { get; set; }

        public string RefreshToken { get; set; }

        public DateTime TokenCreated { get; set; }
        
        public int TokenExpires { get; set; }
    }
}