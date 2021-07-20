class AddUserColumnToTasks < ActiveRecord::Migration[6.1]
  def change
    add_reference :tasks, :user, foreign_key: true
    add_reference :tasks, :author, foreign_key: { to_table: :users }
  end
end
