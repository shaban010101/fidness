class TrainersController < ApplicationController
  def index
    @trainers = Trainer.active
  end

  def show
    @trainer = Trainer.find params[:id]
    @options = Option.all
  end
end
