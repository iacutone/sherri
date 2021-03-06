###
# Compass
###

# Change Compass configuration
# compass_config do |config|
#   config.output_style = :compact
# end

###
# Page options, layouts, aliases and proxies
###

# Per-page layout changes:
#
# With no layout
# page "/path/to/file.html", :layout => false
#
# With alternative layout
# page "/path/to/file.html", :layout => :otherlayout
#
# A path which all have the same layout
# with_layout :admin do
#   page "/admin/*"
# end

# Proxy pages (http://middlemanapp.com/dynamic-pages/)
# proxy "/this-page-has-no-template.html", "/template-file.html", :locals => {
#  :which_fake_page => "Rendering a fake page with a local variable" }

###
# Helpers
###

# Automatic image dimensions on image_tag helper
# activate :automatic_image_sizes

# Reload the browser automatically whenever files change
set :file_watcher_ignore, [
    /^\.idea\//,
    /^\.bundle\//,
    /^\.sass-cache\//,
    /^\.git\//,
    /^\.gitignore$/,
    /\.DS_Store/,
    /^build\//,
    /^\.rbenv-.*$/,
    /^Gemfile$/,
    /^Gemfile\.lock$/,
    /~$/,
    /(^|\/)\.?#/
]
activate :livereload

# Methods defined in the helpers block are available in templates
# helpers do
#   def some_helper
#     "Helping"
#   end
# end

set :css_dir, 'stylesheets'

set :js_dir, 'javascripts'

set :images_dir, 'images'

# Build-specific configuration
configure :build do
  # For example, change the Compass output style for deployment
  # activate :minify_css

  # Minify Javascript on build
  # activate :minify_javascript

  # Enable cache buster
  # activate :asset_hash

  # Use relative URLs
  # activate :relative_assets

  # Or use a different image path
  # set :http_path, "/Content/images/"
end

aws_config = YAML::load(File.open('aws.yml'))

activate :s3_sync do |s3_sync|
  s3_sync.bucket                = aws_config['s3_bucket']
  s3_sync.region                = aws_config['aws_region']
  s3_sync.aws_access_key_id     = aws_config['access_key_id']
  s3_sync.aws_secret_access_key = aws_config['secret_access_key']
  s3_sync.delete                = true
  s3_sync.after_build           = false
end

activate :cloudfront do |cf|
  cf.access_key_id              = aws_config['access_key_id']
  cf.secret_access_key          = aws_config['secret_access_key']
  cf.distribution_id            = aws_config['cloud_front_dist_id']
  cf.filter                     = /(.html|.xml)/
  cf.after_build                = false
end