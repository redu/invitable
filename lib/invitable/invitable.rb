module Invitable
  module Base
    extend ActiveSupport::Concern
    included do
      has_many :invitations,
               :class_name => "Invitable::Invitation",
               :as => :hostable,
               :dependent => :destroy
    end
  end
end
