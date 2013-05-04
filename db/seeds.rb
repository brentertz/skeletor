# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# Clean house
unless Rails.env.production?
  User.destroy_all
  ActiveRecord::Base.connection.reset_pk_sequence! :users
end

# Bootstrap a user
User.where(email: ENV['bootstrap_user_email']).first_or_create!(
  password: ENV['bootstrap_user_password'],
  password_confirmation: ENV['bootstrap_user_password']
)
