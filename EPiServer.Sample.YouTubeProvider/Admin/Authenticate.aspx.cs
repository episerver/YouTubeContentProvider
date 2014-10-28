using System;
using System.Collections.Generic;
using System.Collections.Specialized;
using System.Linq;
using System.Net;
using System.Text;
using System.Web;
using System.Web.Helpers;
using System.Web.UI;
using System.Web.UI.WebControls;
using EPiServer.Configuration;
using EPiServer.Core;
using EPiServer.PlugIn;
using EPiServer.ServiceLocation;
using EPiServer.Shell;
using EPiServer.Web;
using PlugInArea = EPiServer.PlugIn.PlugInArea;
using System.Reflection;

namespace EPiServer.Sample.YouTubeProvider.Admin
{
    [GuiPlugIn(
        DisplayName = "YouTube", 
        Description = "", 
        Area = PlugInArea.AdminConfigMenu,
        UrlFromModuleFolder = "Admin/Authenticate.aspx")]
    public partial class Authenticate : Shell.WebForms.WebFormsBase
    {
        private YouTubeSettings _currentSettings;

        protected override void OnPreInit(EventArgs e)
        {
            base.OnPreInit(e);
            this.SystemMessageContainer.Heading = "YouTube";
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack && string.IsNullOrEmpty(Request.QueryString["code"]))
            {
                TextboxClientId.Text = CurrentSettings.ClientId;
                TextboxSecret.Text = CurrentSettings.ClientSecret;
            }

			fieldsetAuthenticate.Visible = !string.IsNullOrEmpty(CurrentSettings.ClientId) && !string.IsNullOrEmpty(CurrentSettings.ClientSecret);

            if (!string.IsNullOrEmpty(Request.QueryString["code"]))
            {
                var webClient = new WebClient();
                var resultData = webClient.UploadValues(YouTubeSettings.Oauth2Url,
                    new NameValueCollection
                    {
                        { "client_id", CurrentSettings.ClientId },
                        { "client_secret", CurrentSettings.ClientSecret },
                        { "redirect_uri", GetRedirectUri()},
                        { "grant_type", "authorization_code" },
                        { "code", Request.QueryString["code"] }
                    });
                var result = Json.Decode(Encoding.UTF8.GetString(resultData));

				// Clear settings
				ClearCacheAndToken();

                CurrentSettings.AccessToken = result.access_token;
                CurrentSettings.RefreshToken = result.refresh_token;
                CurrentSettings.TokenCreated = DateTime.Now;
                CurrentSettings.TokenExpires = result.expires_in;
                SettingsRepository.Service.SaveSettings(CurrentSettings);

				Response.Redirect(UriSupport.ResolveUrlFromUIBySettings("Admin/Default.aspx") + "?customdefaultpage=" + Paths.ToResource(typeof(YouTubeProvider), "Admin/Authenticate.aspx"));
            }
        }

        protected void ButtonSaveSettings_Click(object sender, EventArgs e)
        {
			CurrentSettings.ClientId = TextboxClientId.Text.Trim();
			CurrentSettings.ClientSecret = TextboxSecret.Text.Trim();

			// Clear settings
			ClearCacheAndToken();

			actionTab.SetSelectedTab(1);
			fieldsetAuthenticate.Visible = !string.IsNullOrEmpty(CurrentSettings.ClientId) && !string.IsNullOrEmpty(CurrentSettings.ClientSecret);
        }

		protected void ButtonClear_Click(object sender, EventArgs e)
		{
			CurrentSettings.ClientId = string.Empty;
			CurrentSettings.ClientSecret = string.Empty;

			// Clear settings
			ClearCacheAndToken();

			TextboxClientId.Text = string.Empty;
			TextboxSecret.Text = string.Empty;
		}

        protected YouTubeSettings CurrentSettings
        {
            get { return _currentSettings ?? (_currentSettings = SettingsRepository.Service.LoadSettings()); }
        }

	    protected string TokenExpire
	    {
		    get
		    {
			    var timeSpan = new TimeSpan(0, 0, (int) (CurrentSettings.TokenExpires - DateTime.Now.Subtract(CurrentSettings.TokenCreated).TotalSeconds));
			    if (timeSpan.TotalMilliseconds < 0)
				    return "Expired";
			    return string.Format("{0} minutes ans {1} seconds", timeSpan.Minutes, timeSpan.Seconds);
		    }
	    }

        public Injected<YouTubeSettingsRepository> SettingsRepository { get; set; }

        protected string GetRedirectUri()
        {
			return (SiteDefinition.Current.SiteUrl + Paths.ToResource(typeof(YouTubeProvider), "Admin/Authenticate.aspx").Substring(1)).ToLower();
        }

	    private void ClearCacheAndToken()
	    {
			CurrentSettings.AccessToken = string.Empty;
			CurrentSettings.TokenExpires = 0;
			CurrentSettings.TokenCreated = DateTime.Now;
			SettingsRepository.Service.SaveSettings(CurrentSettings);

			var contentProviderManager = ServiceLocator.Current.GetInstance<IContentProviderManager>();
			var youTubeProvider = contentProviderManager.GetProvider(YouTubeSettings.ProviderKey) as YouTubeProvider;
		    if (youTubeProvider != null)
		    {
				youTubeProvider.ClearCacheAndSettings();
			//	DataFactoryCache.RemoveSubTree(youTubeProvider.EntryPoint);
			//	DataFactoryCache.RemovePage(youTubeProvider.EntryPoint);
			}
	    }
    }
}