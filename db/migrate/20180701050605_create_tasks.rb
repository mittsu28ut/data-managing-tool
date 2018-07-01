class CreateTasks < ActiveRecord::Migration[5.2]
  def change
    create_table :tasks do |t|
      t.string :priority
      t.string :name
      t.string :detail
      t.string :status
      t.string :due

      t.timestamps
    end
  end
end
