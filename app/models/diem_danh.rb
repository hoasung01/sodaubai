class DiemDanh < ActiveRecord::Base
  attr_accessible :hoc_ky, :ma_lop, :ma_mon_hoc, :ma_sinh_vien, :nam_hoc, :ngay_vang, :so_tiet_vang, :loai

  belongs_to :lop_mon_hoc, :foreign_key => 'ma_lop', :primary_key => 'ma_lop', :conditions => proc {["ma_mon_hoc = '#{self.ma_mon_hoc}'"]}
  belongs_to :sinh_vien, :foreign_key => 'ma_sinh_vien', :primary_key => 'ma_sinh_vien'
  

  validates :ma_lop, :ma_sinh_vien, :ma_mon_hoc, :presence => true  
  

  after_save :set_default
  before_create :set_tiet_vang
  scope :by_lop_sinhvien_ngay, lambda {|ma_lop,ma_sinh_vien, ngay_vang| 
    where(:ma_lop=>ma_lop).where(:ma_sinh_vien=>ma_sinh_vien).where(:ngay_vang => Time.zone.parse(ngay_vang.to_s))
  }
  

  
  private
  def set_tiet_vang
  	self.so_tiet_vang ||= 0
  end
  def set_default
  	self.nam_hoc = self.lop_mon_hoc.nam_hoc
  	self.hoc_ky = self.lop_mon_hoc.hoc_ky  	  
  end
  
end
