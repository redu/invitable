ActiveRecord::Schema.define do
  begin
    drop_table :invitations
    drop_table :users
  rescue
  end

  create_table :users do |t|
    t.string :email
    t.timestamps
  end

  create_table :invitations do |t|
    t.string :email
    t.string :token
    t.string :hostable_type
    t.string :hostable_id
    t.string :user_id
    t.timestamps
  end
end
