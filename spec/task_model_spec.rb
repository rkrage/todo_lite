require 'spec_helper'

describe 'task validation' do

  it 'is valid with all required fields' do
    task = Task.new sample_task
    expect(task.valid?).to be true
  end

  sample_task.each_key do |key|

    it "is not valid if required field #{key} is missing" do
      task = Task.new sample_task.except(key)
      expect(task.valid?).to be false
    end

  end

end