class CreateTodoItems < ActiveRecord::Migration[7.0]
  def change
    create_table :todo_items do |t|
      t.string :title
      t.text :description
      t.boolean :completed, default: false
      t.belongs_to :todo_list

      t.timestamps
    end
  end
end
