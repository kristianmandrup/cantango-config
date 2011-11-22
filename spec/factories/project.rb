FactoryGirl.define do
  factory :project do
    name                        { Forgery(:name).full_name }
  end
end

