class CreateToDos < ActiveRecord::Migration[5.0]
  def change
    create_table :to_dos do |t|
      t.string :title
      t.text :text
      t.string :status
      t.datetime :deadline
      t.boolean :displayed,   default: true
      t.boolean :achieved,    default: false
      t.references :user, foreign_key: true
      t.references :note, foreign_key: true

      t.timestamps
    end
  end
end
