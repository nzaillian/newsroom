module Stories
  module Parsing
    extend ActiveSupport::Concern

    included do
      def self.extract_content(entry)
        sanitized_content = ""

        if entry.content
          sanitized_content = sanitize(entry.content)
        elsif entry.summary
          sanitized_content = sanitize(entry.summary)
        end

        expand_absolute_urls(sanitized_content, entry.url)
      end

      def self.sanitize(content)
        Loofah.fragment(content.gsub(/<wbr\s*>/i, ""))
              .scrub!(:prune)
              .scrub!(:unprintable)
              .to_s
      end

      def self.expand_absolute_urls(content, base_url)
        doc = Nokogiri::HTML.fragment(content)
        abs_re = URI::DEFAULT_PARSER.regexp[:ABS_URI]

        [["a", "href"], ["img", "src"], ["video", "src"]].each do |tag, attr|
          doc.css("#{tag}[#{attr}]").each do |node|
            url = node.get_attribute(attr)
            unless url =~ abs_re
              node.set_attribute(attr, URI.join(base_url, url).to_s)
            end
          end
        end

        doc.to_html
      end       
    end
  end
end