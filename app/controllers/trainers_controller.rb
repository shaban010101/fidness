class TrainersController < ApplicationController
  def index
    @trainers = Trainer.joins(:profile)
  end

  def show
    @trainer = Trainer.find params[:id]
    @options = Option.all
  end
end
