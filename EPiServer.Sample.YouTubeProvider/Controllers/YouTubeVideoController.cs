using System.Web.Mvc;
using EPiServer.Shell;
using EPiServer.Web.Mvc;
using EPiServer.Sample.YouTubeProvider.Models;
using EPiServer.Framework.DataAnnotations;
using System.Reflection;

namespace EPiServer.Sample.YouTubeProvider.Controllers
{
	[TemplateDescriptor(Inherited = true)]
	public class YouTubeVideoController : PartialContentController<YouTubeVideo>
    {
		public override ActionResult Index(YouTubeVideo currentContent)
        {
			return PartialView(Paths.ToResource(GetType(), "Views/Video.cshtml"), currentContent);
        }
    }
}