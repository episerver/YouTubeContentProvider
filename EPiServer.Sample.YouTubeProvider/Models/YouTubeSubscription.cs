using EPiServer.DataAnnotations;

namespace EPiServer.Sample.YouTubeProvider.Models
{
	/// <summary>
	/// Representing an YouTube subscription.
	/// </summary>
	[ContentType(GUID = "6D805D9B-95C2-4E80-9B21-E7D45E3BE68A",
		DisplayName = "Subscription", AvailableInEditMode = false, GroupName = "YouTube")]
	public class YouTubeSubscription : YouTubeFolder
    {
            
    }
}