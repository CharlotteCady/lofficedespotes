class EventsController < ApplicationController
	before_action :set_event, only: [:show, :edit, :update, :destroy, :approved]
	# before_filter :check_privileges!, only: [:edit, :update, :destroy]
	skip_before_filter :authenticate_user!, only: [:index, :show]


	def new
		@event = Event.new
	end

	def create
		@event = Event.new(event_params)
		if @event.save
			@event.update(user_id: current_user.id, status: "draft")
			flash[:notice] = "Félicitation, votre événement a bien été créé ! Il sera mis en ligne après vérification de notre part :)"
 			redirect_to event_users_path
		else
			render :new
		end
	end

	def show 
		@category_list = eval(@event.category) - [""]
		@marker = Gmaps4rails.build_markers(@event) do |event, marker|
			marker.lat event.latitude
			marker.lng event.longitude
			marker.infowindow event.address
		end
	end

	def index
		@start_day = Date.today
		@end_day = Date.today + 45.days
		@categories = ["Trouver sa voie", "Trouver un job", "Changer de métier", "Changer de boite", "Créer sa boite"]
		category = params[:category]
		address = params[:address]
		@search_events = Event.search_event(category, address)
		if (@search_events == nil)
			@events = Event.approved.order(date: :asc, time: :asc)
		else
			@events = @search_events.approved.order(date: :asc, time: :asc)
		end
	end

	def edit 
	end

	def update
		@event.update(event_params)
		if @event.status == "approved"
			redirect_to event_path(@event)
		else
			redirect_to event_users_path
		end
	end

	def destroy
	  @event.destroy
	end

	def approved
		@event.update(status: "approved")
		respond_to do |format|
		  UserMailer.moderated_event(@event).deliver_now
		  format.html { redirect_to users_event_path }
		  format.js { render layout: false }
		end
	end

	private
	def event_params
		params.require(:event).permit(:title, :description, :subscription_link, 
			:date, :time, :price, :address, :organiser, :website, :status, :bootsy_image_gallery_id, :category => [])
	end
	def set_event
		@event = Event.find(params[:id])
	end
end
