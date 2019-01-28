class BlogsController < ApplicationController
  before_action :set_blog, only: [:show, :edit, :update, :destroy]
  before_action :require_login,except: [:index]
  before_action :correct_user, only: [:edit, :destroy]
  # GET /blogs
  # GET /blogs.json
   def index
   @blogs = Blog.all
   end

  # GET /blogs/1
  # GET /blogs/1.json
  def show
  end

  # GET /blogs/new
  def new
    if params[:back]
      @blog = Blog.new(blog_params)
    else
      @blog = Blog.new
    end
  end
  
  def confirm
    @blog = current_user.blogs.build(blog_params)
    render :new if @blog.invalid?
  end

  # GET /blogs/1/edit
  def edit
  end

  # POST /blogs
  # POST /blogs.json
  def create
   @blog = current_user.blogs.build(blog_params)
   @user = @blog.user.name
    respond_to do |format|
      if @blog.save
        format.html { redirect_to @blog, notice: '思い出が投稿されました' }
        format.json { render :show, status: :created, location: @blog }
      else
        format.html { render :new }
        format.json { render json: @blog.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /blogs/1
  # PATCH/PUT /blogs/1.json
  def update
    respond_to do |format|
      if @blog.update(blog_params)
        format.html { redirect_to @blog, notice: '内容が変更されました！' }
        format.json { render :show, status: :ok, location: @blog }
      else
        format.html { render :edit }
        format.json { render json: @blog.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /blogs/1
  # DELETE /blogs/1.json
  def destroy
    @blog.destroy
    respond_to do |format|
      format.html { redirect_to blogs_url, notice: '思い出が削除されました！' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_blog
      @blog = Blog.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def blog_params
      params.require(:blog).permit(:title, :content,:image, :image_cache)
    end
    
    def require_login
     unless logged_in?
      flash[:error] = "投稿するにはログインをしてください"
      redirect_to new_session_path 
     end
    end
    
    def correct_user
      unless current_user.id == @blog.user_id
        flash[:error] = "他人の投稿は編集できません"
        redirect_to new_session_path
      end
    end
end

