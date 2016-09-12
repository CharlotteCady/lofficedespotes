module RessourceHelper
  def checked_category(area)
    @ressource.category.nil? ? false : @ressource.category.match(area)
  end

  def checked_user_category(area)
    current_user.category.nil? ? false : current_user.category.match(area)
  end

  def checked_tag(area)
    @ressource.tag.nil? ? false : @ressource.tag.match(area)
  end

  def checked_user_tag(area)
    current_user.tag.nil? ? false : current_user.tag.match(area)
  end

  def checked_profil(area)
    @ressource.profil.nil? ? false : @ressource.profil.match(area)
  end

  def checked_user_profil(area)
    current_user.profil.nil? ? false : current_user.profil.match(area)
  end

  def checked_city(area)
    @ressource.city.nil? ? false : @ressource.city.match(area)
  end
end

