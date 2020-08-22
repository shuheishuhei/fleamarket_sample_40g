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
  
  def destroy
  end
  
end
