Rails.application.routes.draw do
  concern :commentable do
    resources :comments, except: [:index, :show]
  end
  concern :imageable do
    resources :images, except: [:index, :show]
  end

  resources :users, only: [:new, :create]
  resources :profile, controller: :users, as: :user, except: [:new, :create], concerns: :imageable
  get "groups/:group_id/invite" => 'groups#send_invite', as: :send_invite
  scope module: 'jefe' do
    resources :groups, except: [:index, :new, :create, :show]
  end
  resources :groups, concerns: :imageable, only: [:show, :new, :create] do
    resources :posts, only: :index
    resources :snippets, only: :index
    resources :users, only: [:index, :show] do
      resources :posts, concerns: :commentable
      resources :snippets, concerns: :commentable
    end
  end
  
  # get '/profile' => 'users#profile'
  # get '/profile/edit' => 'users#edit', as: :edit_user
  # patch '/profile' => 'users#update', as: :user
  # put '/profile' => 'users#update'
  # delete '/profile' => 'users#delete'



  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

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
end
