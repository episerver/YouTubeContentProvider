using System;
using System.Collections.Specialized;
using System.Linq;
using System.Net;
using System.Text;
using System.Web.Helpers;
using EPiServer.Data.Dynamic;

namespace EPiServer.Sample.YouTubeProvider
{
    public class YouTubeSettingsRepository
    {
		private YouTubeSettings _currentSettings;

		public virtual YouTubeSettings CurrentSettings 
		{ 
			get { return _currentSettings ?? (_currentSettings = LoadSettings()); }
			set { _currentSettings = value; }
		}

        private DynamicDataStore Store
        {
            get { return typeof(YouTubeSettings).GetStore(); }
        }

		public virtual bool SaveSettings(YouTubeSettings settings)
        {
            try
            {
                Store.Save(settings, CurrentSettings.Id);
				_currentSettings = settings;
            }
            catch (Exception)
            {
                return false;
            }
            return true;
        }

		public virtual YouTubeSettings LoadSettings()
        {
            var settings = Store.Items<YouTubeSettings>().FirstOrDefault();
			
			if (settings != null) 
				return settings;

			settings = new YouTubeSettings();
			Store.Save(settings);
			return settings;
        }

		public virtual bool ValidateAccessToken()
        {
            if (string.IsNullOrEmpty(CurrentSettings.AccessToken))
                return false;

            // Refresh token
			if (DateTime.Now.Subtract(CurrentSettings.TokenCreated).TotalSeconds >= CurrentSettings.TokenExpires)
            {
                var webClient = new WebClient();
                var resultData = webClient.UploadValues(YouTubeSettings.Oauth2Url,
                    new NameValueCollection
                    {
                        { "client_id", CurrentSettings.ClientId },
                        { "client_secret", CurrentSettings.ClientSecret },
                        { "grant_type", "refresh_token" },
                        { "refresh_token", CurrentSettings.RefreshToken }
                    });
                var result = Json.Decode(Encoding.UTF8.GetString(resultData));

				CurrentSettings.AccessToken = result.access_token;
				CurrentSettings.TokenExpires = result.expires_in;
				CurrentSettings.TokenCreated = DateTime.Now;
				SaveSettings(CurrentSettings);

                return true;
            }
            return true;
        }
    }
}