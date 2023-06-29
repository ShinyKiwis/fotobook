class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :password
      t.string :avatar_img
      t.boolean :is_admin
      t.boolean :is_active

      t.timestamps
    end
  end
end
