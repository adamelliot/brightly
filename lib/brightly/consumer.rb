require 'net/http'

module Brightly
  module Consumer
    class << self
      attr_accessor :theme, :provider_url
    end

    module AssetHelper
      # Return the javascript tag that include the token if the user's authenticated
      def brightly_stylesheet_link_tag
        "<link rel=\"stylesheet\" href=\"#{Brightly::Consumer.provider_url}/stylesheets/#{Brightly::Consumer.theme}.css\" type=\"text/css\" media=\"screen\" charset=\"utf-8\">"
      end
    end
    
    module ActiveRecordHelper
      def brighten(markdown, theme = Brightly::Consumer.theme)
        Net::HTTP.post_form(URI.parse("#{Brightly::Consumer.provider_url}/brighten"), {:markdown => markdown, :theme => theme})
      end
    end
  end
end

::ActionView::Base.send(:include, Brightly::Consumer::AssetHelper) if defined? ::ActionView::Base
::ActiveRecord::Base.send(:include, Brightly::Consumer::ActiveRecordHelper) if defined? ::ActiveRecord::Base
