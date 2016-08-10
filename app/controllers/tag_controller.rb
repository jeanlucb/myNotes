class TagController < ApplicationController

	# GET /tags/:tag
	def index
	  if params[:tag]
	    @tag = params[:tag]
	    @notes = current_user.notes.tagged_with(@tag).order(updated_at: :desc)
	    @to_dos = current_user.to_dos.tagged_with(@tag)
	    
	  else
	  	render 'dashboard#index'
	  end
	end

end
