class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update]
  before_action :require_same_user, only: [:edit, :update, :destroy]
  before_action :authenticate_user!, only: [:edit, :update]
  impressionist

  # GET /users
  # GET /users.json
  def index
    @alumni = User.alumni.alumni_order(params[:page])
    # @user_articles_count = @user_articles
  end

  # GET /users/1
  # GET /users/1.json
  def show
    impressionist(@user)
    # @user_articles = @user.articles.paginate(page: params[:page], :per_page => 4)
  end

  # GET /users/new
  # def new
  #   # @user = User.new
  # end

  # GET /users/1/edit
  def edit
    @user = current_user
    # @testimony = Testimony.find(params[:id])
  end

  # POST /users
  # POST /users.json
  # def create
  #   # debugger
  #   @user = User.new(user_params)

  #   respond_to do |format|
  #     if @user.save
  #       session[:user_id] = @user.id
  #       format.html { redirect_to user_path(@user), notice: 'User was successfully created.' }
  #       format.json { render :show, status: :created, location: @user }
  #     else
  #       format.html { render :new }
  #       format.json { render json: @user.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    @user = current_user
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        bypass_sign_in(@user)
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  # def destroy
  #   @user.destroy
  #   respond_to do |format|
  #     format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
  #     format.json { head :no_content }
  #   end
  # end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.friendly.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:first_name, :last_name, :username, :email, :password, :avatar, :address, :date_of_birth, :password_confirmation, :ig, :fb, :twitter, :handphone, :year_graduated, :faculty, :university, :job, :year_of_entry, :alumni)
    end
    #cant't edit or delete if user not belong to owner user
    def require_same_user
      if current_user != @user
        flash[:alert] = "You only can edit or delet your own user"
        redirect_to users_path
      end
    end
end
