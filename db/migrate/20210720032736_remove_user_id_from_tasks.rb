class RemoveUserIdFromTasks < ActiveRecord::Migration[6.1]
  def change
    remove_column :tasks, :user_id, :integer
    remove_column :tasks, :worker_id, :integer
  end
end
