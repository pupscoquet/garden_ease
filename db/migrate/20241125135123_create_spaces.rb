class CreateSpaces < ActiveRecord::Migration[7.1]
  def change
    create_table :spaces do |t|
      t.string :type_of_space
      t.references :project, null: false, foreign_key: true

      t.timestamps
    end
  end
end
