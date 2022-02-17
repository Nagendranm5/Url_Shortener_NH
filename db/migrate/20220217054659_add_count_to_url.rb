class AddCountToUrl < ActiveRecord::Migration[7.0]
  def change
    add_column :urls, :count, :integer
  end
end
