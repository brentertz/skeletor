# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    #first_name { Faker::Name.first_name }
    #last_name { Faker::Name.last_name }
    #email { "#{first_name}.#{last_name}@#{Faker::Internet.domain_name}".downcase }
    email { Faker::Internet.email }
    password 'secret'
    password_confirmation { |u| u.password }
  end
end
