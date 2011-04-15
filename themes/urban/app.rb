# Use the app.rb file to load Ruby code, modify or extend the models, or
# do whatever else you fancy when the theme is loaded.

module Nesta
  class App
    # Uncomment the Rack::Static line below if your theme has assets
    # (i.e images or JavaScript).
    #
    # Put your assets in themes/urban/public/urban.
    #
    # use Rack::Static, :urls => ["/urban"], :root => "themes/urban/public"
    configure do
            
      Compass.configuration do |config|
        config.project_path = File.dirname(__FILE__)
        config.sass_dir = 'views'
        config.environment = :production
        config.relative_assets = true
        config.http_path = "/"
        config.http_images_path = "../images"
        config.images_dir = "../images"
      end

      set :haml, { :format => :html5 }
      set :sass, Compass.sass_engine_options
    end

    get '/css/:layout.css' do
      content_type 'text/css', :charset => 'utf-8'
      cache scss(params[:layout].to_sym)
    end

    helpers do
      # Add new helpers here.
      def set_common_variables
        @menu_items = Nesta::Menu.for_path('/')
        @site_title = Nesta::Config.title
        @default_author = Nesta::Config.author
        set_from_config(:title, :subtitle, :google_analytics_code)
        @heading = @title
      end
      
      def format_date(date)
        date.strftime('%B %d, %Y')
      end
      
      def format_month( month )
        m = Date::MONTHNAMES[ month ]
      end
      
    end
  end
end
