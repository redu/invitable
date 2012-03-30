FactoryGirl.define do
  factory :invitation, :class => Invitable::Invitation  do
    email "mail@example.com"
    token "t0k3N"
  end
end
