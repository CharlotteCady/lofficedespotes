class AddDateendToEvents < ActiveRecord::Migration
  def change
    add_column :events, :dateend, :date
  end
end
