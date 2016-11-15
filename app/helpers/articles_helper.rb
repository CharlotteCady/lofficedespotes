module ArticlesHelper
  def checked_article_category(area)
    @article.category.nil? ? false : @article.category.match(area)
  end
end
