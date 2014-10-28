<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="VideoBlock.ascx.cs" Inherits="EPiServer.Sample.YouTubeProvider.Blocks.VideoBlock" %>

<style type="text/css">
	.video-container {
    position: relative;
    padding-bottom: 56.25%;
    padding-top: 35px;
    height: 0;
    overflow: hidden;
}

	.video-container iframe {
    position: absolute;
    top:0;
    left: 0;
    width: 100%;
    height: 100%;
}
</style>
<div class="video-container">
	<iframe width="560" height="315" src="//www.youtube.com/embed/<%= CurrentData.VideoId %>" frameborder="0" allowfullscreen></iframe>
</div>