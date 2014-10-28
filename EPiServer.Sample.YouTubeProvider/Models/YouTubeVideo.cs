using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using EPiServer.Core;
using EPiServer.DataAnnotations;
using EPiServer.Framework.Blobs;
using System.ComponentModel.DataAnnotations;
using EPiServer.Web.Routing;

namespace EPiServer.Sample.YouTubeProvider.Models
{
	/// <summary>
	/// Representing an YouTube video.
	/// </summary>
	[ContentType(GUID = "EF7AAD44-B437-478D-95E3-6CA5649B84EA",
		DisplayName = "Video", AvailableInEditMode = false, GroupName = "YouTube")]
	public class YouTubeVideo : MediaData, IYouTubeData
	{
		/// <summary>
		/// The ID that YouTube uses to uniquely identify the resource.
		/// </summary>
		public virtual string ItemId { get; set; }

		/// <summary>
		/// The ID that YouTube uses to uniquely identify the channel that published the resource.
		/// </summary>
		public virtual string ChannelId { get; set; }

		/// <summary>
		/// The channel title of the channel that the resource belongs to.
		/// </summary>
		public virtual string ChannelTitle { get; set; }

		/// <summary>
		/// The description of the resource.
		/// </summary>
		public virtual string Description { get; set; }

		/// <summary>
		/// The date and time that the resource was created. 
		/// </summary>
		public virtual DateTime Published { get; set; }

		/// <summary>
		/// Url to a high resolution version of the thumbnail image. For a video (or a resource that refers to a video), this image is 480px wide and 360px tall. For a channel, this image is 800px wide and 800px tall.
		/// </summary>
		public virtual string ThumbnailUrl { get; set; }

		/// <summary>
		/// The ID that YouTube uses to uniquely identify the video in the playlist.
		/// </summary>
		public virtual string VideoId { get; set; }

		/// <summary>
		/// Gets or sets the generated thumbnail for this media.
		/// </summary>
		[ImageDescriptor(Height = 48, Width = 48)]
		public override Blob Thumbnail
		{
			get { return BinaryData; }
			set { BinaryData = value; }
		}
	}
}