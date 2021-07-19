Rails.application.routes.draw do
  root to: "tasks#index"
  resources :tasks
  devise_for :users
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
end
