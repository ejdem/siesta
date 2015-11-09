class SessionsController < ApplicationController
  def new
  end
  
  def create
    student = Student.find_by(email: params[:session][:email].downcase)
    if student && student.authenticate(params[:session][:password])
      log_in student
      redirect_to student #root_url
    else
      flash.now[:danger] = 'invalid email or password'
      render 'new'
    end
  end
  
  def destroy
    log_out if logged_in?
    redirect_to root_url
  end
end
