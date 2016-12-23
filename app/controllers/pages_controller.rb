class PagesController < ApplicationController
  CATEGORIES =  ["Chercher un job", "Changer de métier", "Changer de boite", "Créer sa boite", "Intraprendre"]
  def about
  end
  def manifeste
  end
  def how
    @categories = CATEGORIES
  end
  def contact
  end
  def mentions_legales
  end
  def pro
  end
end
