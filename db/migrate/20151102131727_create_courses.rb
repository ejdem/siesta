class CreateCourses < ActiveRecord::Migration
  def change
    create_table :courses do |t|
      t.string :name
      t.string :short_name
      t.integer :ects

      t.timestamps null: false
    end
  end
end
