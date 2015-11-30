class MicropostsController < ApplicationController
    before_action :logged_in_user, only: [:create, :destroy]
    
    def create
        @subject   = Subject.find(params[:subject_id])
        @user      = User.find(params[:user_id])
        @micropost = @user.microposts.new(micropost_params)
        @micropost.subject_id = @subject.id
        if @micropost.save!
            flash[:success] = "post added"
            redirect_to @subject
        else
            flash[:danger] = "post not added"
            redirect_to @subject
        end
    end
    
    def destroy
    end
    
    private
    def micropost_params
        params.require(:micropost).permit(:content, :title, :user_id, :subject_id)
    end
end
