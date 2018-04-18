Rails.application.routes.draw do
  namespace :api, defaults: {format: :json},
  			constraints: {subdomain: 'api'}, path: '/' do
    scope module: :v1, constraints: APIConstraints.new(version: 1, default: true) do
      post 'signup', to: 'users#create'
      post 'add_friend', to: 'friendships#create'
      get 'get_friends', to: 'friendships#get_friends'
      get 'get_common_friends', to: 'friendships#get_common_friends'
      post 'follow', to: 'followings#create'
    end
  end
end