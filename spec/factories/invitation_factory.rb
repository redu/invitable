FactoryGirl.define do
  factory :invitation, :class => Invitation  do
    email "mail@example.com"
    token "t0k3N"
  end
end
