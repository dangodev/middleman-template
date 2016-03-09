# --------------------------------------
#   Config
# --------------------------------------

page '/*.xml', layout: false
page '/*.json', layout: false
page '/*.txt', layout: false

# ----- Assets ----- #

set :css_dir, 'assets/stylesheets'
set :js_dir, 'assets/javascripts'
set :images_dir, 'assets/images'
set :fonts_dir, 'assets/fonts'

# ----- Images ----- #

# activate :automatic_image_sizes
#
# activate :imageoptim do |options|
#   options.verbose = true
#
#   options.image_extensions = %w(.png .jpg .gif .svg)
#
#   options.advpng    = { :level => 4 }
#   options.gifsicle  = { :interlace => false }
#   options.jpegoptim = { :strip => ['all'], :max_quality => 50 }
#   options.jpegtran  = { :copy_chunks => false, :progressive => true, :jpegrescan => true }
#   options.optipng   = { :level => 6, :interlace => false }
#   options.pngcrush  = { :chunks => ['alla'], :fix => false, :brute => false }
#   options.pngout    = { :copy_chunks => false, :strategy => 0 }
#   options.svgo      = {}
#
# end

# --------------------------------------
#   Helpers
# --------------------------------------

# --------------------------------------
#   Content
# --------------------------------------

# ----- Directories ----- #

activate :directory_indexes
page "/404.html", directory_index: false


# --------------------------------------
#   Development
# --------------------------------------

# ----- Output ----- #

set :haml, {attr_wrapper: '"'}
activate :minify_html do |html|
  html.remove_quotes = false
  html.remove_intertag_spaces = true
end

# ----- Optimization ----- #

configure :build do
  activate :minify_css
  activate :minify_html do |html|
    html.remove_quotes = false
    html.remove_intertag_spaces = true
  end
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
