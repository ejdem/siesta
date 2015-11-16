class CreateUsers < ActiveRecord::Migration
  def change
    
    create_table :users do |t|
      t.string   :name
      t.string   :surname
      t.boolean  :tutor, default: false
      t.string   :email
      t.integer  :album

      t.timestamps null: false
    end
  end
end
