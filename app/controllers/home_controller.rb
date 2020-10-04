class HomeController < ApplicationController
  def index
    @trainers = Trainer.all.limit(3)
  end
end
