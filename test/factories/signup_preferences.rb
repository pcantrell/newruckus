# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :signup_preference do
    signup nil
    composer_night nil
    status "MyString"
  end
end
