FactoryGirl.define do
  factory :user do
    first_name 'Иван'
    last_name 'Иванов'
    institution 'Институт'
    email 'mail@mail.ru'
    password '12345678'
    password_confirmation '12345678'

    trait :fail_name do
      first_name 'А'
    end
  end
end