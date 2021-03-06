class Task < ApplicationRecord
  validates :status, presence: true
  validates :deadline, presence: true

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

  def is_outdated?
    if self.deadline.nil?
      return false
    end
    return self.deadline < Time.current
  end

  scope :index_all, -> {
    all
      .order(created_at: :asc)
      .where.not(status: Task.statuses[:done])
      .includes(:user)
  }

end
