module ToDosHelper

  # Indicates a summary of a whole todo's list:
  # - If there are late notes: the label is their number
  # - If there are no late notes, the label is the number of
  #   the notes that are due for today
  def todo_label (list)
		open = 0
		today = 0
		late = 0
		# Scans the list and counts late and today's tasks
		list.each do |t|
			if t.not_achieved?
				if t.deadline < Time.now
					late = late +1
				elsif t.deadline.today?
					today = today +1
				else
					open = open + 1
				end
			end
		end
		# Defines the 'label' and 'number' output values
		if late != 0
			label = "danger"
			number = late
		elsif today != 0
			label = "warning"
			number = today
		else
			label = "primary"
			number = open
		end

		return {:label => label, :number => number}

  end

end
