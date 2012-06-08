require 'spec_helper'

describe "LayoutLinks" do

  it "should have a Home page at '/'" do
    get '/'
    response.should have_selector("title",
                                 content: "Start")
  end
  it "should have a Contact page at '/contact'" do
    get '/contact'
    response.should have_selector("title",
                                 content: "Kontakt")
  end
  it "should have a About page at '/about'" do
    get '/about'
    response.should have_selector("title",
                                 content: "About")
  end
  it "should have a Help page at '/help'" do
    get '/help'
    response.should have_selector("title",
                                 content: "Hilfe")
   end

  it "should have the right links on the layout" do
    visit root_path
    click_link "About"
    response.should have_selector('title',
                                  content: "About")
    click_link "Hilfe"
    response.should have_selector('title',
                                  content: "Hilfe")
    click_link "Kontakt"
    response.should have_selector('title',
                                  content: "Kontakt")
    click_link "Start"
    response.should have_selector('title',
                                  content: "Start")
    click_link "Registrieren!"
    response.should have_selector('title',
                                  content: "Registrieren")
  end
  describe "when not signed in" do
    it "should have a signin link" do
      visit root_path
      response.should have_selector("a", href: signin_path,
                                    content: "Anmelden")

    end
  end
  describe "when signed in" do
    before(:each) do
      @user = FactoryGirl.create(:user)
      visit signin_path
      fill_in :email, with: @user.email
      fill_in :password, with: @user.password
      click_button
    end
    it "should have a signou link" do
      visit root_path
      response.should have_selector("a", href: signout_path, content: "Abmelden")
    end
    it "should have a profile link" do
      visit root_path
      response.should have_selector("a", href: user_path(@user),
                                    content: "Profil")
    end
  end
end
