<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="PlaylistBlock.ascx.cs" Inherits="EPiServer.Sample.YouTubeProvider.Blocks.PlaylistBlock" %>
<h2><%= CurrentData.Name%></h2>
<p><%= CurrentData.Description %></p>
<br /><br />
<asp:repeater ID="RepeaterItems" runat="server">
	<ItemTemplate>
		<div class="listResult">
			<a href="https://www.youtube.com/watch?v=<%# Eval("VideoId") %>" target="_blank">
				<img src="<%# Eval("ThumbnailUrl") %>" height="100">
			</a>
			<h3>
				@item.Name
			</h3>
			<p class="date">@item.Published</p>
		
			<p>@item.Description</p>
			<hr />
		</div>
	</ItemTemplate>
</asp:repeater>