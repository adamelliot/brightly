module Brightly
  module Consumer
    class << self
      attr_accessor :theme, :provider_url
    end

    module AssetHelper
      # Return the javascript tag that include the token if the user's authenticated
      def brightly_stylesheet_link_tag
        "<link rel=\"stylesheet\" href=\"#{Brightly::Consumer.provider_url}\\stylesheets\\#{Brightly::Consumer.theme}.css\" type=\"text/css\" media=\"screen\" charset=\"utf-8\">"
      end
    end
  end
end

# If using rails add the brightly_stylesheet_link_tag to action view
::ActionView::Base.send(:include, Brightly::Consumer::AssetHelper) if defined? ::ActionView::Base
