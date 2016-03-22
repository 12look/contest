class WorksController < ApplicationController
  before_action :set_work, only: [:show, :edit, :update, :destroy, :set_rating]
  before_action :authenticate_user!, except: [:index, :show, :update_works]
  before_action :authorized_user, only: [:edit, :update, :destroy]


  def set_rating
    @criterions = Criterion.all
    if request.get?
      render "rating/new"
    else
      if Rating.where("user_id=?", current_user.id).empty?
        params[:size].each do |i, val|
          @rating = Rating.new
          @rating.user = current_user
          @rating.work = @work
          @rating.criterion = Criterion.find(i)
          @rating.size = val
          @rating.save
        end
        @rating = Rating.where("user_id=?", current_user.id).all
        @rait = @rating.average(:size)
        @rating1 = @work.ratings.all
        @allrait = @rating1.average(:size)
      else
        redirect_to works_path, notice: "Вы уже оценили"
        return
      end
      render "rating/result"
    end
  end

  # GET /works
  # GET /works.json
  def index
    @works = Work.all.order('created_at DESC')

    if request.xhr?
      render partial: "work", collection: @works
    end
  end

  def update_works
    @works = Work.where("category_id=?", params[:category_id]).all
    if !@works.empty?
      render partial: "work", collection: @works
    else
      render partial: "nothing"
    end
  end

  # GET /works/1
  # GET /works/1.json
  def show
  end

  # GET /works/new
  def new
    @work = current_user.works.build
  end

  # GET /works/1/edit
  def edit
  end

  # POST /works
  # POST /works.json
  def create
    @work = current_user.works.build(work_params)

    respond_to do |format|
      if @work.save
        format.html { redirect_to @work, notice: 'Работа создана успешно' }
        format.json { render :show, status: :created, location: @work }
      else
        format.html { render :new }
        format.json { render json: @work.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /works/1
  # PATCH/PUT /works/1.json
  def update
    respond_to do |format|
      if @work.update(work_params)
        format.html { redirect_to @work, notice: 'Работа обновлена' }
        format.json { render :show, status: :ok, location: @work }
      else
        format.html { render :edit }
        format.json { render json: @work.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /works/1
  # DELETE /works/1.json
  def destroy
    @work.destroy
    respond_to do |format|
      format.html { redirect_to works_url, notice: 'Work was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_work
      @work = Work.find(params[:id])
    end

    def authorized_user
      @work = current_user.works.find_by(id: params[:id])
      redirect_to works_path, notice: "Вы не авторизованы" if @work.nil?
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def work_params
      params.require(:work).permit(
          :name, :description, :user_id, :category_id, :file,
          images_attributes: [ :image, :_destroy, :id ])
    end
end
