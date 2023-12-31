class UsersController < ApplicationController

  before_action :is_matching_login_user, only: [:edit, :update]
 
  def show
    @book = Book.new
    @user = User.find(params[:id])
    @books = @user.books
    @currentUserEntry = Entry.where(user_id: current_user.id)
    @userEntry = Entry.where(user_id: @user.id)
    @todaybook = @books.created_today
    @yesterdaybook = @books.created_yesterday
    @thisweekbook = @books.created_thisweek
    @lastweekbook = @books.created_lastweek
    unless @user.id == current_user.id
      @currentUserEntry.each do |cu| 
        @userEntry.each do |u| 
          if cu.room_id == u.room_id 
            @isRoom = true
            @roomId = cu.room_id
          end
        end
      end
      if @isRoom
      else
        @room = Room.new
        @entry = Entry.new
      end
    end
    
  end

def edit
  @user = User.find(params[:id])
end

def update
  @user = User.find(params[:id])
  if @user.update(user_params)
    flash[:notice] = "You have updated user successfully."
    redirect_to user_path(current_user.id)
  else
    render :edit
  end
end

def index
  @book = Book.new
  @user = current_user
  @users = User.all
end

def search
  @user = User.find(params[:user_id])
  @books = @user.books 
  @book = Book.new
  if params[:created_at] == ""
    @search_book = "日付を選択してください"
  else
    create_at = params[:created_at]
    @search_book = @books.where(['created_at LIKE ? ', "#{create_at}%"]).count
  end
end


  private

  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end

  def is_matching_login_user
    user = User.find(params[:id])
    unless user.id == current_user.id
      redirect_to user_path(current_user)
    end
  end
end
