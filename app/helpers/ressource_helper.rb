module RessourceHelper
  def checked_category(area)
    @ressource.category.nil? ? false : @ressource.category.match(area)
  end

  def checked_tag(area)
    @ressource.tag.nil? ? false : @ressource.tag.match(area)
  end

  def checked_profil(area)
    @ressource.profil.nil? ? false : @ressource.profil.match(area)
  end

  def checked_city(area)
    @ressource.city.nil? ? false : @ressource.city.match(area)
  end
end

