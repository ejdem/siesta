class CreateNotes < ActiveRecord::Migration
  def change
    create_table :notes do |t|
      t.float   :note
      t.string  :bywords
      t.integer :subject_id
      t.integer :user_id
      t.string  :author

      t.timestamps null: false
    end
    
    
  end
end
