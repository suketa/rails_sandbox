FactoryBot.define do
  factory :assignment do
    role { "Role1" }
    employee
    project
  end
end
