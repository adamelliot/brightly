require 'sinatra/base'
require 'rdiscount'
require 'uv'

module Brightly
  module Provider
    class Base < Sinatra::Base
      enable :logging, :static
      set :root, File.dirname(__FILE__)
      
      configure :development do
        enable :dump_errors
      end

      # Process the input text and generate the Textilized page
      post '/brighten' do
        process_markdown(params[:markdown], params[:theme])
      end
      
      private
        def process_markdown(markdown, theme)
          output = ""
          embeds = ""
          
          while !(open = markdown.index(/<code [^>]*language=/m, 0)).nil?
            output << markdown[0, open]

            close = n = open
            begin
              close = markdown.index(/<\/\s*code\s*>/m, close + 1)
              n = markdown.index(/<code [^>]*language=/m, n + 1)
            end while !n.nil? && n < close

            inner_open = open + markdown[/<code[^>]*>/m].length
            inner_close = close
            close = markdown.index(">", close) + 1

            language = markdown[/<code [^>]*language\s*=\s*(['"])([^\1]*?)\1[^>]*>/m, 2]
            embed = markdown[/<code [^>]*embed\s*=\s*(['"])([^\1]*?)\1[^>]*>/m, 2]

            code = markdown[inner_open, inner_close - inner_open]

            output << Uv.parse(code, "xhtml", language, false, theme)
            embeds << embed_code(code, language) unless embed.nil?
            markdown = markdown[close, markdown.length]
          end

          output << markdown

          embeds + RDiscount.new(output).to_html
        end

        def embed_code(code, type)
          case type
          when "javascript" then "<script type=\"text/javascript\">#{code}</script>\n"
          when "css"        then "<style>#{code}</style>\n"
          end
        end
    end
  end
end
