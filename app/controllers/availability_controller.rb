class AvailabilityController < ApplicationController

  def create
    available_at = Time.zone.parse(availability_params[:available_at])
    availability = Availability.create(available_at: availability_params[:available_at], user_id: availability_params[:user_id])

    if availability
      head :created
    else
      render(json: { errors: availability.errors.full_messages }, status: 422)
    end
  end

  def index
    available_at = DateTime.parse(params[:available_at]).to_date
    return render(json: { periods: [] }, status: 200) if available_at.past?
    
    periods = Availability.select(:available_at).where('available_at >= ?', available_at.beginning_of_day)
    .where('available_at <= ?', available_at.end_of_day)
    .where(user_id: params[:user_id])
    formatted_periods = periods.map do |period|
      period.available_at.iso8601
    end
    
    render(json: { periods: formatted_periods }, status: 200)
  end

  private

  def availability_params
    params.permit(:user_id, :available_at)
  end
end
