require 'spec_helper'

class User < ActiveRecord::Base
  include Invitable::Base

  def process_invitation!(invitee, invitation)
    # Do anything
    invitation.delete
  end
end

describe Invitation do

  subject {
    user = Factory(:user)
    FactoryGirl.build(:invitation, :user => user, :hostable => user)
  }
  xit { should validate_uniqueness_of :token }

  context ':Callbacks:' do
    it 'Token should be generated before validate invitation' do
      subject.token = nil
      subject.should be_valid
      subject.token.should_not be_nil
    end
  end

  context ':Associations:' do
    it 'Invitations should have a sender' do
      should belong_to :user
    end

    it 'An Invitation have only one host' do
      should_not have_many :hostables
      should belong_to :hostable
    end

    it 'Users have one or more invitations' do
      user = Factory(:user)
      user.should have_many :invitations
    end

    it 'When a user is deleted, all his invitations should be deleted' do
      subject.save.should be_true
      lambda {subject.user.destroy}.should change(Invitation, :count).by(-1)
      subject.user.should be_destroyed
    end
  end

  context 'Validations' do
    it "Invalid email on invite should make a invalid invitation" do
      subject.email = 'invalid.com'
      subject.should_not be_valid
      subject.errors[:email].should_not be_empty
    end

    it "Invitations without email should be invalid" do
      subject.email = nil
      subject.should_not be_valid
      subject.errors[:email].should_not be_empty
    end

    it "User can't invite himself" do
      subject.email = subject.user.email
      subject.should_not be_valid
    end
  end

  context ':Friends invitations:' do

    it "User can invite other user" do
      subject.save
      expect {
        subject.accept!(Factory(:user)).should == subject
      }.to change(Invitation, :count).by(-1)
    end

    it "Invites to same email should not be valid when sended to same hostable" do
      subject.save
      invitation = FactoryGirl.build(:invitation, :user => Factory(:user), :hostable => subject.hostable, :email => subject.email)
      invitation.should_not be_valid
      invitation.errors[:email].should_not be_empty
      subject.destroy
    end

    it "Invitation can not be accepted if it is not saved" do
      invitation = FactoryGirl.build(:invitation, :email => nil)
      invitation.accept!(Factory(:user)).should be_nil
    end

    it "Create and send email invitation with static method" do
      expect {
        i = Invitation.invite(:user => subject.user, :hostable => subject.hostable, :email => subject.email) do |invitation|
          # Send email block
          invitation.email = 'change@email.org'
        end
        i.email.should == 'change@email.org'
      }.to change { Invitation.all.count }.from(0).to(1)
    end

    it "User can delete invitations" do
      subject.save
      lambda { subject.destroy }.should change(Invitation, :count).by(-1)
      subject.user.invitations.should_not include(subject)
    end
  end
end
