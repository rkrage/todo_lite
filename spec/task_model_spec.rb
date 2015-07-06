require 'spec_helper'

describe 'task validation' do

  it 'is valid with all required fields' do
    task = Task.new SAMPLE_TASK
    expect(task.valid?).to be true
  end

  SAMPLE_TASK.each_key do |key|

    it "is not valid if required field #{key} is missing" do
      task = Task.new SAMPLE_TASK.except(key)
      expect(task.valid?).to be false
    end

  end

end