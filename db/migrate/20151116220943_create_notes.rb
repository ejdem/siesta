class CreateNotes < ActiveRecord::Migration
  def change
    create_table :notes do |t|
      t.float      :note
      t.integer    :subject_id
      t.integer    :user_id
      t.string     :author
      t.timestamps null: false
    end
    
    add_index :notes, [:user_id, :subject_id]
  end
end
