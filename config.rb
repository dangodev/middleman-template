# --------------------------------------
#   Config
# --------------------------------------

# ----- Livereload ----- #

activate :livereload

# ----- Site ----- #

set :site_url, 'http://SITEURL'

# ----- Assets ----- #

set :css_dir, 'assets/stylesheets'
set :js_dir, 'assets/javascripts'
set :images_dir, 'assets/images'
set :fonts_dir, 'assets/fonts'

# ----- Images ----- #

activate :automatic_image_sizes

activate :imageoptim do |options|
  options.verbose = true

  options.image_extensions = %w(.png .jpg .gif .svg)

  options.advpng    = { :level => 4 }
  options.gifsicle  = { :interlace => false }
  options.jpegoptim = { :strip => ['all'], :max_quality => 100 }
  options.jpegtran  = { :copy_chunks => false, :progressive => true, :jpegrescan => true }
  options.optipng   = { :level => 6, :interlace => false }
  options.pngcrush  = { :chunks => ['alla'], :fix => false, :brute => false }
  options.pngout    = { :copy_chunks => false, :strategy => 0 }
  options.svgo      = {}

end

# --------------------------------------
#   Helpers
# --------------------------------------

helpers do

  def nav_link(link_text, url, options = {})
    exact_match = options.delete(:exact_match)
    options[:class] ||= ''
    if exact_match
      options[:class] << ' is-active' if url == current_page.url
    else
      options[:class] << ' is-active' if current_page.url.include?(url)
    end
    link_to(link_text, url, options)
  end

  def path_to_url(path)
    url_for(app, path)
  end

  def pretty_date(date)
    d = Time.parse(date)
    d.strftime("%B #{d.day.ordinalize}, %Y")
  end

end

# --------------------------------------
#   Content
# --------------------------------------

# ----- Directories ----- #

activate :directory_indexes
page "/404.html", directory_index: false

# --------------------------------------
#   Production
# --------------------------------------

# ----- Output ----- #

set :haml, {ugly: true, attr_wrapper: '"'}
activate :minify_html do |html|
  html.remove_quotes = false
end

# ----- Optimization ----- #

configure :build do
  activate :minify_css
  activate :minify_javascript
  activate :relative_assets
  activate :gzip
end

# ----- Prefixing ----- #

activate :autoprefixer do |config|
  config.browsers = ['last 1 version', 'Explorer >= 10']
  config.cascade  = false
end

# --------------------------------------
#   Production
# --------------------------------------

activate :deploy do |deploy|
  deploy.method = :git # gh-pages
  # Optional Settings
  # deploy.remote   = 'custom-remote' # remote name or git url, default: origin
  # deploy.branch   = 'custom-branch' # default: gh-pages
  # deploy.strategy = :submodule      # commit strategy: can be :force_push or :submodule, default: :force_push
  # deploy.commit_message = 'custom-message'      # commit message (can be empty), default: Automated commit at `timestamp` by middleman-deploy `version`
end
