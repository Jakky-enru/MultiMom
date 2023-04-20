class BlogsController < ApplicationController
  before_action :set_blog, only: %i[ edit update destroy ]
  before_action :authenticate_user!#, only: [:new, :create]
  

  # GET /blogs or /blogs.json
  def index
    if current_user.role == "parent"
      # parent_user_ids = User.where(role: 'parent').pluck(:id)
      # @blogs = Blog.where(user_id: parent_user_ids).order(created_at: :desc)
      @blogs = Blog.joins(:user).where(user: { role: "parent"}).order(created_at: :desc)
    elsif current_user.role == "child"
      @blogs = Blog.joins(:user).where(user: { role: "child"}).order(created_at: :desc)
    else
      redirect_to new_user_session_path
    end
    @q = @blogs.ransack(params[:q])
    @blogs = @q.result(distinct: true).order("created_at desc")
  end

  # GET /blogs/1 or /blogs/1.json
  def show
    @blog = Blog.find(params[:id])
    @comments = @blog.comments
    @comment = @blog.comments.build
  
  end

  # GET /blogs/new
  def new
    @blog = Blog.new
  end

  # GET /blogs/1/edit
  def edit
  end

  # POST /blogs or /blogs.json
  def create
    # @blog = Blog.new(blog_params)
    # @blog.user_id = current_user.id
    @blog = current_user.blogs.build(blog_params)

    respond_to do |format|
      if @blog.save
        format.html { redirect_to blogs_path, notice: "Blog was successfully created." }
        format.json { render :show, status: :created, location: @blog }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @blog.errors, status: :unprocessable_entity }
      end
    end
  end

  def confirm
    # @blog = Blog.new(blog_params)
    # @blog.user_id = current_user.id
    @blog = current_user.blogs.build(blog_params)
    render :new if @blog.invalid?
  end

  # PATCH/PUT /blogs/1 or /blogs/1.json
  def update
    respond_to do |format|
      if @blog.update(blog_params)
        format.html { redirect_to blog_url(@blog), notice: "Blog was successfully updated." }
        format.json { render :show, status: :ok, location: @blog }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @blog.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /blogs/1 or /blogs/1.json
  def destroy
    @blog.destroy

    respond_to do |format|
      format.html { redirect_to blogs_url, notice: "Blog was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_blog
      @blog = Blog.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def blog_params
      params.require(:blog).permit(:content)
    end
end
