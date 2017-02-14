class EventsController < ApplicationController
	before_action :set_event, only: [:show, :edit, :update, :destroy]
	# before_filter :check_privileges!, only: [:edit, :update, :destroy]
	skip_before_filter :authenticate_user!, only: [:index, :show]


	def new
		@event = Event.new
	end

	def create
		@event = Event.new(event_params)
		if @event.save
			@event.update(user_id: current_user.id)
			redirect_to event_path(@event)
		else
			render :new
		end
	end

	def show 
		@category_list = eval(@event.category) - [""]
		@marker = Gmaps4rails.build_markers(@event) do |event, marker|
			marker.lat event.latitude
			marker.lng event.longitude
		end
	end

	def index
		@events = Event.all.order(date: :asc, time: :asc).limit(20)
		@categories = ["Trouver sa voie", "Trouver un job", "Changer de métier", "Changer de boite", "Créer sa boite"]
		@start_day = Date.today
		@end_day = Date.today + 60.days
		
		(@start_day..@end_day).each do |date|
			# @events_date_match = Event.where(date: date)
		end	

	end

	def edit 
	end

	def update
		@event.update(event_params)
		redirect_to event_path(@event)
	end

	def destroy
	  @event.destroy
	  redirect_to events_path
	end

	private
	def event_params
		params.require(:event).permit(:title, :description, :subscription_link, 
			:date, :time, :price, :address, :organiser, :website, :category => [])
	end
	def set_event
		@event = Event.find(params[:id])
	end
end
