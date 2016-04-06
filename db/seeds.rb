# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
[:admin, :jury, :participant].each do |role|
  Role.find_or_create_by( name: role )
end
# @user = User.find_by_email("test@example.com")
# @user.add_role :juryAdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password')
#AdminUser.create!(:email => 'admin@example.com', :password => 'password', :password_confirmation => 'password')
AdminUser.create!(email: 'waplookoff@gmail.com', password: 'n18nM3{X&{Ux}]u', password_confirmation: 'n18nM3{X&{Ux}]u')