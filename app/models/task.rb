class Task < ApplicationRecord
  belongs_to :user
  belongs_to :worker, class_name: 'User', foreign_key: 'worker_id', required: false
end
