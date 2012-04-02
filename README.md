# Invitable

Rails 3 generic mail invitation manager.

**NOTE:** You should have a `User` model, that identify the sender of invite.

## Installation

Add this line to your application's Gemfile:

    gem 'invitable'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install invitable


## Configure

* Include the module `Invitable::Base` on User model.

  ```ruby
  class User < ActiveRecord::Base
    include Invitable::Base
  end
  ```

*  Define a method process_invitation! on your invitable model. This method contains the business logic related to acceptance of invitations

  ```ruby
  class User < ActiveRecord::Base
    include Invitable::Base

    # invitee => User instance
    # invitation => Invitation instance
    def process_invitation!(invitee, invitation)
      # invitations between users are friendships invitations
      self.friends << invitee
    end
  end
  ```

## Usage

* Create invitation with send email logic. When invitation is accepted, the block is executed.

```ruby
Invitation.invite(:user => user,
                  :hostable => user,
                  :email => email) do |invitation|
  UserMailer.friendship_confirmation(invitation).deliver
end
```
* Accept invitation

```ruby
invitation = Invitation.first()
invitation.accept!(new_user)
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
