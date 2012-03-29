Factory.define(:user) do |u|
  u.sequence(:email) { |n| "email#{n}@example.com"}
end
