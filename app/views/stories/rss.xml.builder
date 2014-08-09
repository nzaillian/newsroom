cache ['rss', @stories.first] do
  xml.rss(version: '2.0') {
    xml.channel {
      xml.title("Newsroom RSS Feed")
      xml.link(request.host)
      xml.description("Your Consolidated RSS Feed from the Newsroom App (https://github.com/nzaillian/newsroom)")

      @stories.each do |story|
        xml.item {
          xml.guid(story.uuid)
          xml.pubdata(story.published.to_s(:rfc822))
          xml.title(story.title)
          xml.link(story.permalink)
          xml.description(story.body)
        }
      end      
    }
  }
end