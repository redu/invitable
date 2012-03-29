module Invitable
  module Base
    extend ActiveSupport::Concern
    included do
      has_many :invitations,
               :as => :hostable,
               :dependent => :destroy
    end
  end
end
