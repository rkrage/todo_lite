require 'spec_helper'

describe 'user validation' do

  it 'is valid with all required fields' do
    user = User.new sample_user
    expect(user.valid?).to be true
  end

  sample_user.each_key do |key|

    it "is not valid if required field #{key} is missing" do
      user = User.new sample_user.except(key)
      expect(user.valid?).to be false
    end

  end

  invalid_emails.each do |email|

    it "is not valid with bad email address #{email}" do
      user = User.new(sample_user.merge({email_address: email}))
      expect(user.valid?).to be false
    end

  end

  it 'is not valid if email is not unique' do
    user = User.new sample_user
    expect(user.save).to be true
    user = User.new sample_user
    expect(user.valid?).to be false
  end

end