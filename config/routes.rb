RentMap::Application.routes.draw do
  resources :offers, :only => :index

  root :to => "offers#index"
end
