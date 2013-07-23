class LopMonHocSinhViensController < ApplicationController
  # GET /lop_mon_hoc_sinh_viens
  # GET /lop_mon_hoc_sinh_viens.json
  before_filter :load_lop

  def groupupdate
    @msvs = params[:nhom].keys
    #puts msvs.inspect
    @svs = @lop_mon_hoc.get_sinh_viens.select {|k| @msvs.include?(k.ma_sinh_vien)}
    @svs.each do |sv|
      sv.group_id = params[:nhom][sv.ma_sinh_vien].to_i
      sv.save
    end
    #params["nhom"].each do |k,v|
     # sv = @svs.select {|s| s.ma_sinh_vien == k}.first
      #if sv then 
       # sv.group_id = v.to_i
        #sv.save! rescue "Save group error"
      #end
    #end
    #puts params.inspect
    respond_to do |format|
      format.js
    end
  end
  def index
    #@lop_mon_hoc_sinh_viens = LopMonHocSinhVien.all
    @lop_mon_hoc_sinh_viens = @lop_mon_hoc.get_sinh_viens
    @group = @lop_mon_hoc.group
    @groups_arrays = {}
    @group.times do |g|
      @groups_arrays[(g+1).to_s] = "Group #{g+1}"
    end
    #@groups_arrays = @groups.map {|gr| ["Group #{gr.id}", gr.id] }
    respond_to do |format|
      format.html { render :layout => false if request.headers['X-PJAX']}
      format.json { render json: @lop_mon_hoc_sinh_viens }
    end
    
  end

  # GET /lop_mon_hoc_sinh_viens/1
  # GET /lop_mon_hoc_sinh_viens/1.json
  def show
    @lop_mon_hoc_sinh_vien = @lop_mon_hoc.get_sinh_viens.find(params[:id])

    respond_to do |format|
      format.html { render :layout => false if request.headers['X-PJAX']}
      format.json { render json: @lop_mon_hoc_sinh_vien }
    end
  end

  # GET /lop_mon_hoc_sinh_viens/new
  # GET /lop_mon_hoc_sinh_viens/new.json
  def new
    @lop_mon_hoc_sinh_vien = @lop_mon_hoc.lop_mon_hoc_sinh_viens.build

    respond_to do |format|
      format.html { render :layout => (request.headers['X-PJAX'] ? false : true)}
      format.json { render json: @lop_mon_hoc_sinh_vien }
    end
  end

  # GET /lop_mon_hoc_sinh_viens/1/edit
  def edit
    @lop_mon_hoc_sinh_vien = @lop_mon_hoc.get_sinh_viens.find(params[:id])
  end

  # POST /lop_mon_hoc_sinh_viens
  # POST /lop_mon_hoc_sinh_viens.json
  def create
    @lop_mon_hoc_sinh_vien = @lop_mon_hoc.lop_mon_hoc_sinh_viens.build(params[:lop_mon_hoc_sinh_vien])

    respond_to do |format|
      if @lop_mon_hoc_sinh_vien.save
        format.html { flash[:success] = "Created OK";
          render :index, :layout => (request.headers['X-PJAX'] ? false : true)  }
        format.json { render json: @lop_mon_hoc_sinh_vien, status: :created, location: @lop_mon_hoc_sinh_vien }
      else
        format.html { render action: "new" }
        format.json { render json: @lop_mon_hoc_sinh_vien.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /lop_mon_hoc_sinh_viens/1
  # PUT /lop_mon_hoc_sinh_viens/1.json
  def update
    @lop_mon_hoc_sinh_vien = @lop_mon_hoc.get_sinh_viens.find(params[:id])

    respond_to do |format|
      if @lop_mon_hoc_sinh_vien.update_attributes(params[:lop_mon_hoc_sinh_vien])
        format.html { redirect_to [@lop_mon_hoc,@lop_mon_hoc_sinh_vien], notice: 'Lop mon hoc sinh vien was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @lop_mon_hoc_sinh_vien.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /lop_mon_hoc_sinh_viens/1
  # DELETE /lop_mon_hoc_sinh_viens/1.json
  def destroy
    @lop_mon_hoc_sinh_vien = @lop_mon_hoc.get_sinh_viens.find(params[:id])
    @lop_mon_hoc_sinh_vien.destroy

    respond_to do |format|
      format.html { redirect_to lop_mon_hoc_lop_mon_hoc_sinh_viens_url(@lop_mon_hoc) }
      format.json { head :no_content }
    end
  end

  protected
  def load_lop
    @lop_mon_hoc = LopMonHoc.find(params[:lop_mon_hoc_id])      
    @malop = @lop_mon_hoc.ma_lop
    @mamonhoc = @lop_mon_hoc.ma_mon_hoc
  end
end
