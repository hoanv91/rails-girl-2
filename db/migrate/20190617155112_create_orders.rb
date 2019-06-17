class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
      t.string :first_name
      t.string :last_name
      t.string :state
      t.string :address
      t.string :city
      t.string :postcode
      t.string :phone
      t.string :email
      t.string :payment_method
      t.references :cart, foreign_key: true
      t.float :total

      t.timestamps
    end
  end
end
