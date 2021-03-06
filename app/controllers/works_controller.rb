class WorksController < ApplicationController
  before_action :find_work, only: [:show, :edit, :update, :destroy]

  def index
    @works = Work.all

    @albums = Work.where(category: "album")
    @books = Work.where(category: "book")
    @movies = Work.where(category: "movie")
  end

  def show
  end

  def new
    @valid_categories = VALID_CATEGORIES
    @work = Work.new

  end

  def create
    @work = Work.create(work_params)
    if @work.save
        flash[:success] = "#{@work.title} created"
      redirect_to work_path(@work.id)
    else
      flash.now[:alert] = @work.errors
      render :new
    end
  end

  def edit
  end

  def update
    if !@work.nil?
      if @work.update(work_params)
        redirect_to work_path(@work.id)
      else
        render :edit
      end
    else
      redirect_to works_path
    end
  end

  def destroy
    if @work
      @work.votes.each do |vote|
        vote.destroy
      end
      @work.destroy
      if !@work.title.nil?
        flash[:success] = "#{@work.title} deleted"
      else
        flash[:success] = "Work deleted"
      end
    else
      flash[:alert] = "Work does not exist"
    end
    redirect_to works_path
  end

  private
  def work_params
    return params.require(:work).permit(:category, :title, :creator, :publication_year, :description)
  end

  def find_work
    @work = Work.find_by(id: params[:id])
  end

end
