class NotesController < ApplicationController
    
    def new
        if current_user.tutor?
            @note = Note.new
        else
            flash[:danger] = "you cannot add notes!"
        end
    end
    
    def create
        @subject = Subject.find(params[:subject_id])
        user    = User.find(params[:user_id])
        @note   = user.notes.new(note_params)
        @note.save!
        flash[:success] = "note added"
        redirect_to @subject
    end
    
    private
    
    def note_params
            params.require(:note).permit(:subject_id,
                                         :user_id,
                                         :note)
    end
end
