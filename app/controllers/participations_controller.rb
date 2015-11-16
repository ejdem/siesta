class ParticipationsController < ApplicationController

    def create
        subject = Subject.find(params[:subject_id])
        current_user.participate(subject)
        redirect_to subject
    end
    
    private
    
end
