Rails.application.routes.draw do
  resource :configuration, only: [:edit, :update]

  resources :examples
  resource :reverts, only: [:create]
  resource :agrees, only: [:create]
  resource :feedbacks, only: [:new, :show, :create]
  resource :kodaks
  resource :blasts, only: [:create]
  resource :dispositions_prepare_listing_panes, only: [:create]
  resource :underwriting_intake_form_panes, only: [:create]
  resource :intake_form_completions, only: [:create, :destroy]
  resources :property_disposition_checklists, only: [:update]
  resource :filters, only: [:create]
  resource :statuses, only: [:update]

  resource :inquiries, only: [:create]
  resource :gallery, only: [:create]
  resources :addendum_versions, only: [:create, :update]
  resource :repc_deliveries, only: [:create]
  resource :searches, only: [:create]
  resources :repcs, only: [:update]
  resources :repc_verdicts, only: [:create]
  resources :addendum_verdicts, only: [:create]
  resource :account
  resources :contacts, only: [:index, :create] do
    collection do
      get 'refresh'
    end
  end
  resource :contact_searches, only: [:create]
  resource :scouts, only: [:create]
  resource :tx_scout_links, only: [:create]

  resources :themes, only: [:edit, :update]
  resources :projects, only: [:index, :new, :create] do
    member do
      get 'overview'
      get 'offer'
      get 'inspection'
      get 'inspection_inspection_report'
      get 'dispositions_checklist'
      get 'dispositions_prepare_listing'
      get 'underwriting_review_offer'
      get 'underwriting_prepare_repc'
      get 'underwriting_property_analysis'
      get 'underwriting_intake_form'
      get 'marketplace'
      get 'files'
      get 'activity'

      post 'download_property_analysis'
    end
  end
  get '/projects', to: 'projects#index'

  resources :addendums, only: [:show]

  namespace :projects do
    get 'searches/index'
  end
  resources :projects do
    collection do
      post :advanced_search, to: "projects/searches#advanced_search"
    end
  end

  resources :listings
  get '/bids/:id', to: 'listings#bid'

  devise_for :users,
             controllers: {
               sessions: 'users/sessions' }

  get '/privacy_', to: 'pages#privacy_'
  get '/privacy', to: 'pages#privacy'

  post '/webhook', to: 'webhooks#webhook'
  get '/webhook_signed_by_company', to: 'webhooks#webhook_signed_by_company'
  get '/webhook_revert', to: 'webhooks#webhook_revert'
  post '/webhook_sendgrid_event', to: 'webhooks#webhook_sendgrid_event'

  get '/offer/:token', to: 'repcs#show'
  get '/offer/:token/feedback/new', to: 'feedbacks#new'
  get '/offer/:token/feedback', to: 'feedbacks#show'

  get '/offer-addendum/:token/feedback/new', to: 'feedbacks#new'
  get '/offer-addendum/:token/feedback', to: 'feedbacks#show'

  root to: "pages#landing"
end
