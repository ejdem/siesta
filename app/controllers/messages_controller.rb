class MessagesController < ApplicationController
    include sessions_helper

    def create
        @message = current_user.sended_messages.new(message_params)
        @name    = "name"
        if @message.save!
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
        params.require(:message).permit(:messaage,
                                        :title,
                                        :receiver_id,
                                        :sender_id)
    end
end
