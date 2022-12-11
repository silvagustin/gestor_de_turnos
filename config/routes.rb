Rails.application.routes.draw do
  devise_for :users,
    path: '',
    path_names: {
      sign_in: 'login',
      sign_out: 'logout',
      sign_up: 'register'
    },
    skip: [:passwords]

  devise_scope :user do
    authenticated do
      root to: 'sucursales#index', as: :authenticated_root
    end

    unauthenticated do
      root to: 'devise/sessions#new', as: :unauthenticated_root
    end
  end

  resources :users

  resources :sucursales do
    resources :horarios, only: %i( edit update )
    resources :turnos, except: %i( index show destroy )
  end

  resources :turnos, only: %i( index show destroy )
end
