class SubjectsController < ApplicationController
   helper_method :create_participation
    def new
        @subject = Subject.new
    end
    
    def create
        @subject = Subject.new(subject_params)
        if @subject.save
            flash[:success] = "subject added"
            redirect_to @subject
        else
            render 'pages/home'
        end
    end
    
    def show
        @subject    = Subject.find(params[:id])
        @microposts = @subject.microposts.paginate(page: params[:page], per_page: 5)
        @micropost  = current_user.microposts.new if logged_in?
    end
    
    def index
         @subjects = Subject.paginate(page: params[:page], :per_page => 10)
    end
    
    def edit
        @subject = Subject.find(params[:id])
    end
    
    def update
        @subject = Subject.find(params[:id])
        if @subject.update_attributes(subject_params)
            flash[:success] = "subject updated"
            redirect_to @subject
        else
            render 'edit'
        end
    end
    
   def destroy
        Subject.find(params[:id]).destroy
        flash[:success] = "subject deleted"
        redirect_to subjects_url
   end
    
    private
    
    def subject_params
        params.require(:subject).permit(:name,
                                       :description,
                                       :ects)
    end

end