class AddTuanAndSisoToLichTrinhGiangDay < ActiveRecord::Migration
  def change
    add_column :lich_trinh_giang_days, :tuan, :integer
  end
end
