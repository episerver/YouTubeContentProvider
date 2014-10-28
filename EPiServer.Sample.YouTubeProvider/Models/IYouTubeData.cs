using System;

namespace EPiServer.Sample.YouTubeProvider.Models
{
	/// <summary>
	/// Defines common properties for all YouTube resource types.
	/// </summary>
    public interface IYouTubeData
    {
		/// <summary>
		/// The ID that YouTube uses to uniquely identify the resource.
		/// </summary>
        string ItemId { get; set; }

		/// <summary>
		/// The ID that YouTube uses to uniquely identify the channel that published the resource.
		/// </summary>
		string ChannelId { get; set; }

		/// <summary>
		/// The channel title of the channel that the resource belongs to.
		/// </summary>
		string ChannelTitle { get; set; }
		
		/// <summary>
		/// The description of the resource.
		/// </summary>
		string Description { get; set; }
		
		/// <summary>
		/// The date and time that the resource was created. 
		/// </summary>
		DateTime Published { get; set; }
			
		/// <summary>
		/// Url to a high resolution version of the thumbnail image. For a video (or a resource that refers to a video), this image is 480px wide and 360px tall. For a channel, this image is 800px wide and 800px tall.
		/// </summary>
		string ThumbnailUrl { get; set; }
    }
}