Rails.application.routes.draw do
  root to: "tasks#index"
  get 'task/:id/assign' => 'tasks#assign', as: 'assign_task'
  patch 'task/:id/assign' => 'tasks#update_assignment', as: 'update_assignment'
  get 'tasks/mine' => 'tasks#my_tasks'
  resources :tasks

  devise_for :users

  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
end
