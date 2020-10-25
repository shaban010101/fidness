class HomeController < ApplicationController
  def index
    @trainers = Trainer.joins(:profile).limit(3)
  end
end
