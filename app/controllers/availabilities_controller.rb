class AvailabilitiesController < ApplicationController
  authorize_resource
  def index
    @availabilities = User.find(current_user.id).availabilities
  end

  def new
    @availability = Availability.new
  end

  def create
    @availability = current_user.availabilities.build(availability_params)

    if @availability.save
      redirect_to user_path(current_user), notice: 'Added availability with success.'
    else
      render 'new'
    end
  end

  def destroy
    @availability = Availability.find(params[:id])
    @availability.destroy

    redirect_to user_path(current_user.id)
  end

  private

  def availability_params
    params.require(:availability).permit(:week_day, :start_time, :end_time)
  end
end
