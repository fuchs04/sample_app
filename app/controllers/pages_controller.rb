class PagesController < ApplicationController
  def home
    @title = "Start"
  end

  def contact
    @title = "Kontakt"
  end

  def about
    @title = "About"
  end

  def help
    @title = "Hilfe"
  end
end
