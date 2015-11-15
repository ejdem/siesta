class SubjectsController < ApplicationController
   
    def new
        @subject = Subject.new
    end
    
    def show
        @subject = Subject.find(params[:id])
    end
    
    def index
        @subjects = Subject.all
    end
    
    def edit
    end
    
    def edit
    end

end
