class CreateStudents < ActiveRecord::Migration
  def change
    create_table :students do |t|
      t.string  :name
      t.string  :surname
      t.string   :email
      t.integer  :album
      t.timestamps null: false
    end
  end
end
