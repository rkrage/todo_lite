require 'spec_helper'

describe '/tasks' do

  before :all do
    @open_task_id = Task.all.incomplete.sample.id
    @completed_task_id = Task.all.complete.sample.id
  end

  it 'partially update a task' do
    payload = { title: 'my task', description: 'get the groceries' }
    patch "/tasks/#{@open_task_id}", payload
    expect_status 200
    get "/tasks/#{@open_task_id}"
    expect_status 200
    expect_json payload
  end

  it 'delete a task' do
    id = Task.where.not(id: [@open_task_id, @completed_task_id]).sample.id
    delete "/tasks/#{id}"
    expect_status 204
    get "/tasks/#{id}"
    expect_status 404
  end

  it 'mark task as complete' do
    get "/tasks/#{@open_task_id}"
    expect_status 200
    expect_json_types complete_date: :null
    put "/tasks/#{@open_task_id}/complete"
    expect_status 200
    get "/tasks/#{@open_task_id}"
    expect_status 200
    expect_json_types complete_date: :string
  end

  it 'mark task as open' do
    get "/tasks/#{@completed_task_id}"
    expect_status 200
    expect_json_types complete_date: :string
    put "/tasks/#{@completed_task_id}/reopen"
    expect_status 200
    get "/tasks/#{@completed_task_id}"
    expect_status 200
    expect_json_types complete_date: :null
  end

end