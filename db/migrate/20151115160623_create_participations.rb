class CreateParticipations < ActiveRecord::Migration
  def change
    create_table :participations do |t|
      t.integer :user_id,    index: true
      t.integer :subject_id, index: true

      t.timestamps null: false
    end
    add_index :participations, [:user_id, :subject_id], unique: true
    add_index :participations, :user_id
    add_index :participations, :subject_id
  end
end
