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

    trait :fail_last_name do
      last_name 'А'
    end

    trait :fail_institution do
      institution 'А'
    end
  end
end