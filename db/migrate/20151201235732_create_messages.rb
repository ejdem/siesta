class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.text       :message
      t.references :sender, index: true, foreign_key: true
      t.references :receiver, index: true, foreign_key: true

      t.timestamps null: false
    end
    add_index :messages, [:sender_id, :receiver_id]
  end
end
