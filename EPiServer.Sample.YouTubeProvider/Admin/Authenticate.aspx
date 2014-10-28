<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Authenticate.aspx.cs" Inherits="EPiServer.Sample.YouTubeProvider.Admin.Authenticate" %>
<%@ Import Namespace="EPiServer" %>
<%@ Import Namespace="EPiServer.Shell" %>
<%@ Import Namespace="EPiServer.Web" %>
<%@ Register TagPrefix="episerverui" Namespace="EPiServer.UI.WebControls" Assembly="EPiServer.UI" %>
<asp:Content ContentPlaceHolderID="MainRegion" runat="server">
    
    <EPiServerUI:TabStrip  runat="server" id="actionTab" EnableViewState="true" GeneratesPostBack="False" targetid="tabView" supportedpluginarea="SystemSettings">
        <EPiServerUI:Tab Text="Summary" runat="server" ID="TabSummary" />
        <EPiServerUI:Tab Text="Configuration" runat="server" ID="TabConfiguration" />
		<EPiServerUI:Tab Text="Help" runat="server" ID="TabHelp" />
    </EPiServerUI:TabStrip>

    <asp:Panel runat="server" ID="tabView" CssClass="epi-formArea epi-paddingHorizontal epi-padding">
        <div runat="server">
            <fieldset>
                <legend>Overview</legend>    
                <dl>
					<dt>Token created</dt>
                    <dd><%= CurrentSettings.TokenCreated %></dd>
					<dt>Token is renewed in</dt>
	                <dd><%= TokenExpire %></dd>
                </dl>
            </fieldset>
        </div>
        
        <div runat="server">
            <fieldset>
                <legend>OAuth 2.0 Settings</legend>    
                <dl>
                    <dt>Client Id</dt>
                    <dd><asp:TextBox ID="TextboxClientId" runat="server" /></dd>
                    <dt>Secret</dt>
                    <dd><asp:TextBox ID="TextboxSecret" runat="server" /></dd>
                </dl>
                <div class="floatright">
                    <episerverui:toolbutton id="ButtonClear" runat="server" OnClick="ButtonClear_Click" text="<%$ Resources: EPiServer, button.clear %>" tooltip="<%$ Resources: EPiServer, button.clear %>"  skinid="Delete" />
					<episerverui:toolbutton id="ButtonSaveSettings" runat="server" OnClick="ButtonSaveSettings_Click" text="<%$ Resources: EPiServer, button.save %>"  tooltip="<%$ Resources: EPiServer, button.save %>"  skinid="Save" />
                </div>
				
			</fieldset>
			<fieldset id="fieldsetAuthenticate" runat="server">
                <legend>Authenticate</legend>
				<div>
					Click in the hyperlink below to authenticate your YouTube account and start access your YouTube content in the editorial interface.
				</div>
				<p>
					<a href="https://accounts.google.com/o/oauth2/auth?approval_prompt=force&client_id=<%= CurrentSettings.ClientId %>&redirect_uri=<%= HttpUtility.UrlEncode(GetRedirectUri()) %>&scope=https://www.googleapis.com/auth/youtube&response_type=code&access_type=offline" 
						target="_top">Click to Authenticate</a>
				</p>
			</fieldset>
        </div>
		
		<div runat="server">
			<div class="epi-paddingVertical">
				<p>
					The YouTube content provider uses YouTube Data API (v3) to incorporate YouTube functionality into EPiServer and must have authorization credentials to be able to use the API. EPiServer does not provide the credentials but these you can create yourself by the Google Developers Console.<br/>
					<br/>
					Follow the steps below to setup the YouTube content provider.
					
					<h3>Setup instructions</h3>

					<ol>
						<li>1. Go to the <a href="https://console.developers.google.com/" target="_blank">Google Developers Console</a><br/><br/></li>
						<li>2. Click on the <b>Create Project</b> button<br/><br/></li>
						<li>3. In the dialog, type in a <b>project name</b> and <b>project id</b>, click the <b>Create</b> button<br/><br/></li>
						<li>4. Wait until the project is created, after a few seconds the <b>project dashboard</b> is displayed<br/><br/></li>
						<li>6. In the sidebar on the left, select <b>APIs & auth</b> and then <b>APIs</b>. In the list of APIs, make sure the status is <b>ON</b> for the <b>YouTube Data API v3</b>.<br/><br/></li>
						<li>
							7. In the sidebar on the left, select <b>Consent screen</b>.<br/><br/>
							<ol>
								<li>- Select your <b>Email address</b> and type in a <b>Product name</b><br/><br/></li>
								<li>- Click on the <b>Save</b> button</li>
							</ol>
							<br/>
						</li>
						<li>8. In the sidebar on the left, select <b>Credentials</b>.<br/><br/></li>
						<li>9. Below the <b>OAuth</b> section, click the <b>Create new Client ID</b> button<br/><br/></li>
						<li>
							10. In the <b>Create Client ID</b> dialog, select <b>Web application</b> as the type<br/><br/>
							<ol>
								<li>- In the <b>Authorized JavaScript origins</b>, copy and paste this url: <b><%= SiteDefinition.Current.SiteUrl %></b><br/><br/></li>
								<li>- In the <b>Authorized redirect URI</b>, copy and paste this url: <b><%= GetRedirectUri() %></b></li>
							</ol>
							<br/>
						</li>
						<li>11. Click on the <b>Create Client ID</b> button<br/><br/></li>
						<li>12. Copy and paste the newly created <b>Client ID</b> and <b>Client secret</b> keys in the respective text fields in the Configuration tab <br/><br/></li>
						<li>13. Click on the <b>Save</b> button  in the Configuration tab and then click on the <b>Click to Authenticate</b> link<br/><br/></li>
					</ol>
				</p>
			</div>

			

		</div>
    </asp:Panel>

    
 </asp:Content>