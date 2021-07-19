Rails.application.routes.draw do
  resources :tasks
  devise_for :users
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
end
