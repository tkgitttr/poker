class CreateCards < ActiveRecord::Migration[5.2]
  def change
    create_table :cards do |t|
      t.string :all_card
      t.string :first_card
      t.string :second_card
      t.string :third_card
      t.string :fourth_card
      t.string :fifth_card

      t.timestamps
    end
  end
end
