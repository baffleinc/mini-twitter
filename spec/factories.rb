FactoryGirl.define do
  factory :user do
    sequence(:name)  { |n| "Person #{n}" }
    sequence(:email) { |n| "person_#{n}@example.com"}
    password "foobar"
    password_confirmation "foobar"
    age 18
    gender "male"

    factory :admin do
      admin true
    end
  end

  factory :micropost do
    content "Dolan pls"
    user
  end
end