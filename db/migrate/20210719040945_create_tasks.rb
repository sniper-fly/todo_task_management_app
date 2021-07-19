class CreateTasks < ActiveRecord::Migration[6.1]
  def change
    create_table :tasks do |t|
      t.string :title
      t.text :content
      t.datetime :deadline
      t.datetime :start_date
      t.integer :status

      t.timestamps
    end
  end
end
