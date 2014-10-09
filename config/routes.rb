Rails.application.routes.draw do

  root to: 'users#index'

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
end
