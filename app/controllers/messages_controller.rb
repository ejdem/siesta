class MessagesController < ApplicationController
    #include sessions_helper
    before_action :logged_in_user, only: [:create, :destroy]
    
    def create
        @user    = User.find(params[:receiver_id])
        @message_s = current_user.sended_messages.new(message_params)
        @message_r = @user.received_messages.new(message_params)
        #@user    = User.find(params[:user_id])
        #@message.receiver_id = @user.id
        if @message_s.save! && @message_r.save!
            flash[:success] = "message sent"
            redirect_to current_user
        else
            flash[:danger] = "message not sent"
            redirect_to current_user
        end
    end
    
    def index
        @user = current_user
    end
    
    def destroy
    end
    
    private
    
    def message_params
        params.require(:message).permit(:message,
                                        :title,
                                        :receiver_id,
                                        :sender_id)
    end
end
