using EPiServer.DataAnnotations;
namespace EPiServer.Sample.YouTubeProvider.Models
{
	/// <summary>
	/// Representing an YouTube playlist.
	/// </summary>
	[ContentType(GUID = "F6BEC55B-84B7-41C9-BD9E-AA962F13BB9D",
		DisplayName = "Playlist", AvailableInEditMode = false, GroupName = "YouTube")]
    public class YouTubePlaylist : YouTubeFolder
    {
            
    }
}