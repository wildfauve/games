Games::Application.routes.draw do
  
  root :to => "games#index"
  
  resources :games do
    resources :hands
    member do
      put 'recalc'
    end    
  end
    
  
  resources :players
  
  
end
