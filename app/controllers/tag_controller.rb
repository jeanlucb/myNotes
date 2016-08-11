class TagController < ApplicationController

	# GET /tags/:tag
	def index
	  if params[:tag]
	    @tag = params[:tag]
	    @notes = current_user.notes.tagged_with(@tag).order(updated_at: :desc)
	    # Finds to-do's tagged with :tag, but not linked to notes in @notes
	    @to_dos = independent_to_dos(@notes, current_user.to_dos.tagged_with(@tag))
	    
	  else
	  	render 'dashboard#index'
	  end
	end




	private

		def independent_to_dos (notes, tasks)
			if notes and tasks
				list = Array.new
				tasks.each do |t|
					if not(@notes.find_index(t.note)) or t.note.nil?
						list << t
					end
				end
				return list
			else
				return nil
			end
		end

end
