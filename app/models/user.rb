class User < ApplicationRecord
  validates :name, presence: true

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable

  has_many :tasks, foreign_key: 'author_id', class_name: 'Task', dependent: :destroy #destroyじゃないようにもできるようにしたい
  has_many :tasks_to_do, foreign_key: 'user_id', class_name: 'Task', dependent: :destroy
end
