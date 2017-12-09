Rails.application.routes.draw do
  
  
  
  namespace :api do
  	namespace :v1 do
  		resources :price
  		# get '/price/insert', to: 'price#insert'
  		# put '/profilesV2/update/:id', to: 'profiles_v2#update'
  	end
  end

  scope '(:locale)', locale: /en|id|sa/  do 
    devise_for :users, controllers: {
      :sessions           => 'users/sessions',
      :registrations      => 'users/registrations',
      # :omniauth_callbacks => "users/omniauth_callbacks" ,
      :invitations        => 'users/invitations'
    }
    devise_scope :user do
      delete 'logout', to: 'devise/sessions#destroy'
      get 'resetpassword', to: 'users/passwords#new'
      # get 'signup', to: 'devise/registrations#new'
      # get 'login', to: 'devise/sessions#new'
    end
    # resources :contacts
    post 'contacts' => 'contacts#create'
    	# mount Monologue::Engine, at: '/blog', :as => :blog	
	  # get 'deposito-bitcoin' => 'pages#deposito_bitcoin', :as => :deposito
	  get 'calculator-bitcoin' => 'pages#calculator_bitcoin', :as => :calculator
	  get 'cara-registrasi-akun-indoexchanger' => 'pages#cara_registrasi_akun', :as => :how_to_register
	  get 'about-us' => 'pages#about_us', :as => :about
    get 'cara-mendapatkan-bitcoin' => 'pages#cara_mendapatkan_bitcoin', :as => :how_to_get_btc
    get 'contact-us' => 'pages#contact_us'
    # get 'cara-daftar-akun-indoexchanger' => 'pages#cara_daftar_akun_indoexchanger', as: => :how_to_register
	  # get '' => 'pages#index'
	  root 'pages#index'
    get 'rivan-juliansyah' => 'pages#rivan', :as => :gobliw
	  
  end
end
