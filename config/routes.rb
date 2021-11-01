Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :events
  resources :venues
  resources :users
  resource :sessions

  put '/users/:id/follow/:following_id', to: 'users#follow', as: 'follow'
  delete '/users/:id/follow/:following_id', to: 'users#unfollow', as: 'unfollow'

  put '/users/:id/save_event/:event_id', to: 'users#save_event', as: 'save_event'
  delete '/users/:id/save_event/:event_id', to: 'users#unsave_event', as: 'unsave_event'

  put '/users/:id/save_venue/:venue_id', to: 'users#save_venue', as: 'save_venue'
  delete '/users/:id/save_venue/:venue_id', to: 'users#unsave_venue', as: 'unsave_venue'
end
