class AddQrcodeStatusToUrl < ActiveRecord::Migration[7.0]
  def change
    add_column :urls, :qrcode, :boolean
  end
end
