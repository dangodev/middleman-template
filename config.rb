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

configure :build do
end

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
