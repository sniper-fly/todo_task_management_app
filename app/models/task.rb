class Task < ApplicationRecord
  belongs_to :user, required: false
  belongs_to :author, class_name: 'User', foreign_key: 'author_id'

  enum statuses: {
    waiting: 0,
    doing: 1,
    done: 2
  }

  STATUS_NAME = {
    Task.statuses[:waiting] => '未対応',
    Task.statuses[:doing] => '対応中',
    Task.statuses[:done] => '完了'
  }

  def get_status_str
    STATUS_NAME[self.status]
  end

  def is_created_by?(user)
    self.author == user
  end

  scope :index_all, -> {
    all
      .order(created_at: :asc)
      .includes(:user)
  }

end
