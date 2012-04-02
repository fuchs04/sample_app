require 'spec_helper'

describe PagesController do

  render_views

  describe "GET 'home'" do
    it "should be successful" do
      get 'home'
      response.should be_success
    end
  end

  describe "GET 'contact'" do
    it "should be successful" do
      get 'contact'
      response.should be_success
    end
  end

  describe "GET 'about'" do
    it "should be successful" do
      get 'about'
      response.should be_success
    end
  end
  describe "GET 'help'" do
    it "should be successful" do
      get 'help'
      response.should be_success
    end
  end
  it "should have the right title 'home'" do
    get 'home'
    response.should have_selector("title",
                                 :content => "Ruby on Rails Tutorial Sample App | Home")
  end
  it "should have the right title 'contact'" do
    get 'contact'
    response.should have_selector("title",
                                 content: " | Contact" )
  end
  it "should have the right title 'about'" do
    get 'about'
    response.should have_selector("title",
                                 content: " | About" )
  end
  it "should have the right title 'help'" do
    get 'help'
    response.should have_selector("title",
                                 content: " | Help" )
  end
end
