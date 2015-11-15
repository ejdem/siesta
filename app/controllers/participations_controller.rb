class ParticipationsController < ApplicationController
    
    def new
        @participation = Participation.new
    end
    
    def create
        @participation = @subject.participations.new(participation_params)
    end
end
