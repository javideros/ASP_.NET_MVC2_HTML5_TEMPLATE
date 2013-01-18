using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using MvcTemplate.Streams;
using System.ServiceModel.Syndication;
using System.Xml;

namespace MvcTemplate.Controllers
{
    public class RssController : Controller
    {
        //
        // GET: /Rss/

        public RssResult Index()
        {
            SyndicationFeed mainFeed = new SyndicationFeed();

            foreach (var feed in GetRssFeeds())
            {
                Uri feedUri = new Uri(feed);
                SyndicationFeed syndicationFeed;
                using (XmlReader reader = XmlReader.Create(feedUri.AbsoluteUri))
                {
                    syndicationFeed = SyndicationFeed.Load(reader);
                }

                syndicationFeed.Id = feed;

                SyndicationFeed tempFeed = new SyndicationFeed(
                    mainFeed.Items.Union(syndicationFeed.Items).OrderByDescending(u => u.PublishDate));
                mainFeed = tempFeed;
            }

            return new RssResult(mainFeed);
        }

        //
        // GET: /rss/test
        public ActionResult Test()
        {
            var jsonData = new string[] { "1", "paper", "3" };
            return Json(jsonData, JsonRequestBehavior.AllowGet);
        }


        private static List<string> GetRssFeeds()
        {
            List<string> feeds = new List<string>();

            feeds.Add("http://feeds2.feedburner.com/WadeWegner");
            feeds.Add("http://www.nickharris.net/feed/");
            feeds.Add("http://feeds.feedburner.com/ntotten");

            return feeds;
        }
    }
}
