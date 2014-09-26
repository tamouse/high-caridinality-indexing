

FactoryGirl.define do
  factory :person do
    family_name { Faker::Name.last_name }
    given_name  { Faker::Name.first_name }
    email       { "#{given_name}.#{family_name}@#{Faker::Internet.domain_name}".downcase.gsub(/[[:space:]]+/, '') }

    factory :person_with_phone do
      phone     { Faker::PhoneNumber.phone_number }
    end
  end
end
