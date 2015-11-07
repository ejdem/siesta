class CreateTutors < ActiveRecord::Migration
  def change
    create_table :tutors do |t|
      t.string :name
      t.string :surname
      t.string :email

      t.timestamps null: false
    end
  end
end
