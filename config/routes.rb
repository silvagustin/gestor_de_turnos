Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  devise_for :users,
    path: '',
    path_names: {
      sign_in: 'login',
      sign_out: 'logout',
      sign_up: 'register'
    },
    skip: [:passwords]

  resources :users

  resources :sucursales do
    resources :horarios, only: %i( edit update )
  end

  resources :turnos
end
