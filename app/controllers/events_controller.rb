class EventsController < ApplicationController
  
  def index
    @events = Event.all
  end

  def show
    @event = Event.find(params[:id])
  end

  def new 
    @event = Event.new
  end

  def edit
    @event = Event.find(params[:id])
  end

  def create
    @event = Event.new(event_params)

    if @event.save
      redirect_to event_path(@event), notice: 'Event Created Sucessfully'
    else
      render 'new'
    end
  end

  def update
    @event = Event.find(params[:id])

    if @event.update(event_params)
      redirect_to event_path, notice: 'Event Updated Sucessfully'
    else
      render 'edit'
    end
  end

  def destroy
    @event = Event.find(params[:id])
    @event.destroy

    redirect_to root_path
  end

  def attend
    @event = Event.find(params[:id])

    if Attendee.find_by(user_id: current_user.id, event_id: @event.id).nil?
      Attendee.create(user_id: current_user.id, event_id: @event.id)
      render 'show'
    else
      render 'show'
    end
  end

  
  def event_params
    params.require(:event).permit(:name, :location, :start_date, :end_date, :description, :hashtag)
  end
end