class EventsController < ApplicationController
	before_action :set_event, only: [:show, :edit, :update, :destroy]
	before_filter :check_privileges!, only: [:edit, :update, :destroy]
	skip_before_filter :authenticate_user!, only: [:new, :create, :index, :show]


	def new
		@event = Event.new
	end

	def create
		@event = Event.new(event_params)
		if @event.save
			redirect_to event_path(@event)
		else
			render :new
		end
	end
	def show 
		@category_list = eval(@event.category) - [""]
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
