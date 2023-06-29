class ChangeColumnsDetailsOfUsers < ActiveRecord::Migration[7.0]
  def up
    change_column_default :users, :is_admin, false
    change_column_default :users, :is_active, true
  end

  def down 
    change_column_default :users, :is_admin, nil
    change_column_default :users, :is_active, nil
  end
end
