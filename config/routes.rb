Rails.application.routes.draw do
  
  devise_for :users, :path => "alumni", controllers: {
    :sessions           => 'users/sessions',
    :registrations      => 'users/registrations',
    :omniauth_callbacks => "users/omniauth_callbacks" ,
    :invitations        => 'users/invitations',
    :confirmations      => 'users/confirmations',
    :passwords          => 'users/passwords'
  }
  scope '(:locale)', locale: /en|id|sa/  do 
    
    resources :articles, :path => "blog"
    resources :testimonies
    devise_scope :user do
      delete 'logout', to: 'devise/sessions#destroy'
      get 'resetpassword', to: 'users/passwords#new'
      # get 'signup', to: 'devise/registrations#new'
      # get 'login', to: 'devise/sessions#new'
    end
    resources :users, :path => 'alumni' 
    resources :students, :path => 'pendaftaran-santri-baru'
    # resources :contacts
    post 'contacts' => 'contacts#create'
    get 'sejarah-al-mizan', to: 'pages#sejarah', as: :sejarah
    get 'visi-misi-al-mizan', to: 'pages#visi', as: :visi_misi
    get 'fasilitas-al-mizan', to: 'pages#facility', as: :facility
    get 'hubungi-kami', to: 'pages#contact_us', as: :contact
    get 'ekstrakurikuler', to: 'pages#ekskul', as: :ekskul
    #get 'pendaftaran-santri-baru', to: 'pages#registration', as: :new_registration_student
    	# mount Monologue::Engine, at: '/blog', :as => :blog	
	  root 'pages#index'
	  
  end
end
