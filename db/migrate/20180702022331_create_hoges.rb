class CreateHoges < ActiveRecord::Migration[5.2]
  def change
    create_table :hoges do |t|
      t.string :name
      t.string :string
      t.string :text
      t.string :string

      t.timestamps
    end
  end
end
