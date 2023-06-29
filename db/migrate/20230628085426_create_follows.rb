class CreateFollows < ActiveRecord::Migration[7.0]
  def change
    create_table :follows do |t|
      t.integer :followee
      t.integer :follower

      t.timestamps
    end
  end
end
