class Tasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|

      t.timestamps null: false
      t.string "subject", null: false
      t.string "description", null: false
      t.datetime "due_date", null: false
      t.boolean "completed", default: false, null: false
      t.belongs_to :user, index: true, null: false

    end
  end
end
