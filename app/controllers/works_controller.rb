class WorksController < ApplicationController
  before_action :set_work, only: [:show, :edit, :update, :destroy, :set_rating]
  before_action :authenticate_user!, except: [:index, :show, :top]
  # before_action :authorized_user, only: [:edit, :update, :destroy]

  authorize_resource only: [:create, :edit, :update, :destroy]

  def user_works
    @works = current_user.works.order('created_at DESC').page(params[:page])
    render 'works/myworks'
  end

  def set_rating
    authorize! :set_rating, @work
    unless Rating.was_rait(@work, current_user).empty?
      redirect_to work_path(@work), alert: 'Вы уже оценили'
      return
    end
    @criterions = Criterion.all
    if request.get?
      render 'works/show'
    else
      params[:size].each do |val|
        unless val[1].to_i.between?(1,10)
          redirect_to @work, alert: 'Неверное значение оценки (корректные от 1 до 10)'
          return
        end
      end
      params[:size].each do |i, val|
        @rating = Rating.new
        @rating.user = current_user
        @rating.work = @work
        @rating.criterion = Criterion.find(i)
        @rating.size = val
        @rating.save
      end
      @rait = Rating.was_rait(@work, current_user).all.average(:size)
      @allrait = @work.ratings.all.average(:size)
      render 'rating/result'
    end
  end

  # GET /top
  def top
    @works = Work.joins(:ratings).uniq
                 .select('works.*, avg(ratings.size) as rait')
                 .group('works.id')
                 .having('count(distinct ratings.user_id) = ?', User.count_jury)
                 .order('rait DESC')
                 .limit(10)
    @works = @works.where('category_id=?', params[:category_id]) if params.has_key? :category_id

    render 'works/top'
  end

  # GET /works
  # GET /works.json
  def index
    @works = Work.all.order('created_at DESC').page(params[:page])

    # if request.xhr?
    #   render partial: "work", collection: @works
    # end
  end

  def update_works
    @works = Work.where('category_id=?', params[:category_id]).order('created_at DESC').all
    if !@works.empty?
      render partial: 'partials/work', collection: @works
    else
      render partial: 'partials/nothing'
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
      format.html { redirect_to works_url, notice: 'Работа успешно удалена.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_work
      @work = Work.find(params[:id])
      @allrait = @work.ratings.all.average(:size)
    end

    def authorized_user
      @work = current_user.works.find_by(id: params[:id])
      redirect_to works_path, notice: 'Вы не авторизованы' if @work.nil?
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def work_params
      params.require(:work).permit(
          :name, :description, :user_id, :category_id, :file, :archive_url,
          images_attributes: [ :image, :_destroy, :id ])
    end
end
