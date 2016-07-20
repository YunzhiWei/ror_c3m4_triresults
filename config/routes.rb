Rails.application.routes.draw do
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  resources :racers do
    post "entries" => "racers#create_entry"
  end
  resources :races

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  namespace :api do
    resources :races, only: [:index, :show, :create, :update, :destroy] do
      resources :results, only: [:index, :show]
    end
    resources :racers, only: [:index, :show] do
      resources :entries, only: [:index, :show]
    end


    # get 'races'                        => "races#index"
    # get 'races/:id'                    => "races#show"
    # get 'races/:race_id/results'       => "races#index"
    # get 'races/:race_id/results/:id'   => "races#show"
  
    # get 'racers'                       => "racers#index"
    # get 'racers/:id'                   => "racers#show"
    # get 'racers/:racer_id/entries'     => "racers#index"
    # get 'racers/:racer_id/entries/:id' => "racers#show"

  end

end
