class AddDefaultStatusToPost < ActiveRecord::Migration[5.2]
  def change
    change_column_default :posts, :status, 1
  end
end
