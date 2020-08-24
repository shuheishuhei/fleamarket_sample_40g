class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
  end

  def index    

  end
  
  def new 
  end

  def create  
    
  end
    
  
  def show
  end
end
