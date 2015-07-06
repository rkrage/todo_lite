require 'spec_helper'

describe '/users' do

  before :all do
    @user_id = User.all.sample.id
  end

  it 'navigate through paginated users' do
    get '/users'
    expect_status 200
    expect_header('X-Per-Page', '25')
    expect_header('X-Page', '1')
    expect(json_body.size).to eq 25
    page_one_user = json_body.first
    get '/users?page=2'
    expect_status 200
    expect_header('X-Per-Page', '25')
    expect_header('X-Page', '2')
    expect(json_body.size).to be > 0
    page_two_user = json_body.first
    expect(page_one_user).to_not eq page_two_user
  end

  it 'get a single user' do
    get "/users/#{@user_id}"
    expect_status 200
    expect_json_types email_address: :string, first_name: :string, last_name: :string
    expect_json id: @user_id
  end

  it 'create a user' do
    post '/users', sample_user
    expect_status 201
  end

  it 'partially update user' do
    payload = { first_name: 'Ryan', last_name: 'Krage' }
    patch "/users/#{@user_id}", payload
    expect_status 200
    get "/users/#{@user_id}"
    expect_status 200
    expect_json payload
  end

  it 'delete user' do
    id = User.where.not(id: @user_id).sample.id
    delete "/users/#{id}"
    expect_status 204
    get "users/#{id}"
    expect_status 404
  end

  it 'view tasks for a user' do
    # incomplete tasks
    get "/users/#{@user_id}/tasks"
    expect_status 200
    incomplete = json_body
    get "/users/#{@user_id}/tasks?complete=true"
    expect_status 200
    expect(incomplete).to_not eq json_body
  end

  it 'create task for a user' do
    task = sample_task.merge(user_id: @user_id)
    post "/users/#{@user_id}/tasks", task
    expect_status 201
    expect_json task
  end

end