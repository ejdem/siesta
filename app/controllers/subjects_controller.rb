class SubjectsController < ApplicationController
   
    def new
        @subject = Subject.new
    end
    
    def create
        @subject = Subject.new
        if @subject.save
            flash[:success] = "subject added"
            redirect_to root_url
        else
            render 'pages/home'
        end
    end
    
    def show
        @subject = Subject.find(params[:id])
    end
    
    def index
         @subjects = Subject.paginate(page: params[:page], :per_page => 10)
    end
    
    def edit
    end
    
    

end
