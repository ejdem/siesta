class ParticipationsController < ApplicationController

    def create
        subject = Subject.find(params[:subject_id])
        current_user.participate(subject, current_user)
        redirect_to subject
        flash[:success] = "now your participate"
        current_user.save!
    end
    
    private
    
end
