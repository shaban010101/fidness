class TrainersController < ApplicationController
  before_action :redirect_if_not_signed_in

  def index
    @trainers = User.where(type: 'Trainer')
  end

  def show
    @trainer = Trainer.find params[:id]
    @options = Option.all
  end
end
