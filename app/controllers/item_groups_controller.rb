class ItemGroupsController < ApplicationController
  # GET /item_groups
  # GET /item_groups.json
  before_filter :authenticate_user!
  load_and_authorize_resource
  def index
    @item_groups = ItemGroup.paginate(:page => params[:page], :per_page => params[:size]? params[:size]:PAGE_SIZE )

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @item_groups }
    end
  end

  # GET /item_groups/1
  # GET /item_groups/1.json
  def show
    @item_group = ItemGroup.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @item_group }
    end
  end

  # GET /item_groups/new
  # GET /item_groups/new.json
  def new
    @item_group = ItemGroup.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @item_group }
    end
  end

  # GET /item_groups/1/edit
  def edit
    @item_group = ItemGroup.find(params[:id])
  end

  # POST /item_groups
  # POST /item_groups.json
  def create
    @item_group = ItemGroup.new(params[:item_group])

    respond_to do |format|
      if @item_group.save
        format.html { redirect_to @item_group, notice: 'Item group was successfully created.' }
        format.json { render json: @item_group, status: :created, location: @item_group }
      else
        format.html { render action: "new" }
        format.json { render json: @item_group.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /item_groups/1
  # PUT /item_groups/1.json
  def update
    @item_group = ItemGroup.find(params[:id])

    respond_to do |format|
      if @item_group.update_attributes(params[:item_group])
        format.html { redirect_to @item_group, notice: 'Item group was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @item_group.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /item_groups/1
  # DELETE /item_groups/1.json
  def destroy
    @item_group = ItemGroup.find(params[:id])
    @item_group.destroy

    respond_to do |format|
      format.html { redirect_to item_groups_url }
      format.json { head :no_content }
    end
  end
end
