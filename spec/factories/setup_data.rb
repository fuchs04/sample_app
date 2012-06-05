# By using the Symbol ':user', we get Factory Girl to sinulate the User model.

FactoryGirl.define do
  factory :user do
    name "Akos Toth"
    email "akostoth@gmx.de"
    password "foobar"
    password_confirmation "foobar"
  end
end
