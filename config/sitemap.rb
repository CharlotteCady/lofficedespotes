# Set the host name for URL creation
SitemapGenerator::Sitemap.default_host = "http://www.workuper.com"
SitemapGenerator::Sitemap.adapter = SitemapGenerator::S3Adapter.new(
aws_access_key_id: ENV['AWS_ACCESS_KEY_ID'],
aws_secret_access_key: ENV['AWS_SECRET_ACCESS_KEY'],
fog_provider: 'AWS',
fog_directory: ENV['S3_BUCKET_NAME'],
fog_region: 'eu-west-1',
path_style: true
)

SitemapGenerator::Sitemap.sitemaps_host = ENV['SITEMAP_HOST']
SitemapGenerator::Sitemap.public_path = 'tmp/'
SitemapGenerator::Sitemap.sitemaps_path = 'sitemaps/'

SitemapGenerator::Sitemap.create do
  add '/about', 'changefreq': 'weekly'
  add '/how', 'changefreq': 'weekly'
  add '/category', 'changefreq': 'daily'
  add ressources_path, :priority => 0.7, :changefreq => 'daily'

  Ressource.find_each do |ressource|
      add ressource_path(ressource.slug), lastmod: ressource.updated_at
    end
  # Put links creation logic here.
  #
  # The root path '/' and sitemap index file are added automatically for you.
  # Links are added to the Sitemap in the order they are specified.
  #
  # Usage: add(path, options={})
  #        (default options are used if you don't specify)
  #
  # Defaults: :priority => 0.5, :changefreq => 'weekly',
  #           :lastmod => Time.now, :host => default_host
  #
  # Examples:
  #
  # Add '/articles'
  #
  #   add articles_path, :priority => 0.7, :changefreq => 'daily'
  #
  # Add all articles:
  #
  #   Article.find_each do |article|
  #     add article_path(article), :lastmod => article.updated_at
  #   end
end

SitemapGenerator::Sitemap.ping_search_engines
