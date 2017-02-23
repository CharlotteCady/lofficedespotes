module EventsHelper
	def checked_event_category(area)
    	@event.category.nil? ? false : @event.category.match(area)
  	end
end
