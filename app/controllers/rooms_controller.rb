class RoomsController < ApplicationController
  def show
    @session = Session.find_by!(room_id: params[:id])
  end
end