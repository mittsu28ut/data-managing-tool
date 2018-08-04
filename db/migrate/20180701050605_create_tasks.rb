class CreateTasks < ActiveRecord::Migration[5.2]
  def change
    create_table :tasks do |t|
      t.integer :user_id
      t.string :priority
      t.string :name
      t.string :detail
      t.string :status
      t.date :due

      t.timestamps
    end
  end
end
