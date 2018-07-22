class CreateCardFormServices < ActiveRecord::Migration[5.2]
  def change
    create_table :card_form_services do |t|

      t.timestamps
    end
  end
end
