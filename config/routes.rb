Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'users/sessions'
  }
  get '/api/test', to: 'api#test'
  root 'welcome#index'
end
