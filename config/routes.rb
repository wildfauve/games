Games::Application.routes.draw do
  
  root :to => "games#index"
  
  resources :games do
    resources :hands
    member do
      put 'recalc'
    end    
  end
    
  
  resources :players
  
  resources :dashboards do 
    collection do
      get 'game_time_line'
    end
  end
  
end
