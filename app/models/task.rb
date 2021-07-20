class Task < ApplicationRecord
  belongs_to :user
  belongs_to :worker, class_name: 'User', foreign_key: 'worker_id', required: false

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

end
