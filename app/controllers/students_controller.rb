class StudentsController < ApplicationController
    
    def new
        @student = Student.new
    end
    
    def show
        @student = Student.find(params[:id])
    end
    
    def create
        @student = Student.new(student_params)
        if @student.save
            flash[:success] = "welcome to SIESTA, activation email sent."
            log_in @student #to be deleted
            redirect_to @student
        else
            render 'new'
        end
    end
    
    private
        def student_params
            params.require(:student).permit(:name,
                                            :email, 
                                            :password, 
                                            :password_confirmation)
        end
    
end
