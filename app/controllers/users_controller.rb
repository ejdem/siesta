class UsersController < ApplicationController
    before_action :logged_in_user, only: [:index, :edit, :update, :destroy]
    before_action :correct_user,   only: [        :edit, :update]
    before_action :admin_user,     only: :destroy
    
    
    def index
        @users = User.paginate(page: params[:page], :per_page => 10)
    end
    def new
        @user = User.new
    end
    
    def show
        @user        = User.find(params[:id])
        @microposts  = @user.microposts.paginate(page: params[:page], per_page: 5)
        @notes       = @user.notes.all
        @messages_r  = @user.received_messages.paginate(page: params[:page], per_page: 10)
        @messages_s  = @user.sended_messages.paginate(page: params[:page], per_page: 10)
        @subject_ids = []
        @notes.each do |n|
            @subject_ids << n.subject_id
        end
        @subject_ids.uniq!
        #subs       =  @subject_ids.count
        #@totl_avr  =  0
        #@notes2    =  []
        #@allnotes  =  []
        #@avrs      =  []
        #@allnotes  << [0]
        #@subject_ids.each do |sid|
        #    @subject = Subject.find(sid)
        #    @notes2   << @subject.notes.where(user_id: @user.id)
        #    @allnotes << @notes2
        #    sum = 0
        #    c   = @allnotes[sid].count
        #    @allnotes[sid].each do |n|
        #        sum += n.note
        #    end
        #    @avrs << sum/c
        #end
        #@total_avr = @avrs.sum / subs
    end
    
    def create
        @user = User.new(user_params)
        if @user.save
            @user.send_activation_email
            flash[:success] = "welcome to SIESTA, activation email sent."
            redirect_to root_url
        else
            render 'new'
        end
    end
    
    def edit
        @user = User.find(params[:id])
    end
    
    def update
        @user = User.find(params[:id])
        if @user.update_attributes(user_params)
            flash[:success] = "profile updated"
            redirect_to @user
        else
            render 'edit'
        end
    end
    
    def destroy
        User.find(params[:id]).destroy
        flash[:success] = "user deleted"
        redirect_to users_url
    end
    
    def participating
        @title = "participating"
        @user  = User.find(params[:id])
        @subjects = @user.subjects.paginate(page: params[:page])
    end
    
    private
    
        def user_params
            params.require(:user).permit(:name,
                                         :email, 
                                         :password, 
                                         :password_confirmation)
        end
    
        def logged_in_user
            unless logged_in?
                store_location
                flash[:danger] = "log in first, please"
                redirect_to login_url
            end
        end
        
        def correct_user
            @user = User.find(params[:id])
            redirect_to(root_url) unless current_user?(@user)
        end
        
        def admin_user
            redirect_to(root_url) unless current_user.admin?
        end
end
