class CreateMarks < ActiveRecord::Migration
  def change
    create_table :marks do |t|
      t.string  :mark_word
      t.float   :mark
      t.integer :user_id
      t.integer :subject_id
      t.integer :tutor_id

      t.timestamps null: false
    end
    add_index :marks, [:user_id, :subject_id], unique: true
    add_index :marks, :user_id
    add_index :marks, :subject_id
    add_index :marks, :tutor_id
  end
end
