class MessagesController < ApplicationController
    include sessions_helper
    def new
    end
    
    def create
    end
    
    def index
        @user = current_user
    end
    
    def delete
    end
end
