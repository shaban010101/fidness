class HomeController < ApplicationController
  def index
    @trainers = Trainer.active.limit(3)
  end
end
