class TrainersController < ApplicationController
  def index
    @trainers = User.where(type: 'Trainer').joins(:profile)
  end

  def show
    @trainer = Trainer.find params[:id]
    @options = Option.all
  end
end
