using System.Web.Mvc;
using System.ServiceModel.Syndication;
using System.Xml;
using System.Web;
using System.Collections.Generic;
namespace MvcTemplate.Streams
{
    public class RssResult : FileResult
    {
        private readonly SyndicationFeed _feed;

        public RssResult(SyndicationFeed feed)
            : base("application/rss+xml")
        {
            _feed = feed;
        }

        public RssResult(string title, List<SyndicationItem> feedItems)
            : base("application/rss+xml")
        {
            _feed = new SyndicationFeed(title, title, HttpContext.Current.Request.Url) { Items = feedItems };
        }
        
        protected override void  WriteFile(HttpResponseBase response)
        {
            using (XmlWriter writer = XmlWriter.Create(response.OutputStream))
            {
                _feed.GetRss20Formatter().WriteTo(writer);
            }
        }
    }
}