Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :events
  resources :venues
  resources :users
  resource :sessions

  root :to => redirect('/sessions/new')
end
