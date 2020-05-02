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
    
    periods = Availability.where('available_at >= ?', available_at.beginning_of_day)
    .where('available_at <= ?', available_at.end_of_day)
    .where(user_id: params[:user_id])
    .pluck(:available_at)
    
    sessions = Session.joins(:purchased_session)
     .where(purchased_sessions: { trainer_id: params[:user_id]})
     .where('session_at >= ?', available_at.beginning_of_day)
     .where('session_at <= ?', available_at.end_of_day)
     .pluck(:session_at)
    
    if current_user.trainer?
      unavailable_times = (periods + sessions).uniq
      formatted_periods = unavailable_times.map do |period|
        period.iso8601
      end
    else
      formatted_periods = periods.reject do |period|
        sessions.include?(period)
      end.map(&:iso8601)
    end
    
    render(json: { periods: formatted_periods }, status: 200)
  end

  private

  def availability_params
    params.permit(:user_id, :available_at)
  end
end
