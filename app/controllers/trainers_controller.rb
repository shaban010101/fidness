class TrainersController < ApplicationController
  def index
    @trainers = User.where(type: 'Trainer')
  end

  def show
    @trainer = Trainer.find params[:id]
    @options = Option.all
  end
end
