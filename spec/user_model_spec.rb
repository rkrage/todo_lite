require 'spec_helper'

describe 'user validation' do

  it 'is valid with all required fields' do
    user = User.new SAMPLE_USER
    expect(user.valid?).to be true
  end

  SAMPLE_USER.each_key do |key|

    it "is not valid if required field #{key} is missing" do
      user = User.new SAMPLE_USER.except(key)
      expect(user.valid?).to be false
    end

  end

  INVALID_EMAILS.each do |email|

    it "is not valid with bad email address #{email}" do
      user = User.new(SAMPLE_USER.merge({email_address: email}))
      expect(user.valid?).to be false
    end

  end

  it 'is not valid if email is not unique' do
    user = User.new SAMPLE_USER
    expect(user.save).to be true
    user = User.new SAMPLE_USER
    expect(user.valid?).to be false
  end

end