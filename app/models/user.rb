class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable

  has_many :tasks, dependent: :destroy #destroyじゃないようにもできるようにしたい
  has_many :tasks_to_do, foreign_key: 'worker_id', class_name: 'Task'
end
