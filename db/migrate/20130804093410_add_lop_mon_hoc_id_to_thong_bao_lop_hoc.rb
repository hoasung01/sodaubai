class AddLopMonHocIdToThongBaoLopHoc < ActiveRecord::Migration
  def change
    add_column :thong_bao_lop_hocs, :lop_mon_hoc_id, :integer
    add_index :thong_bao_lop_hocs, :lop_mon_hoc_id      
  end
end
