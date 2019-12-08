class TutorialsController < ApplicationController
  def show
    tutorial = Tutorial.find(params[:id])
    if tutorial.classroom == true && !current_user
      flash[:error] = "Please log in to see this content"
      redirect_to '/'
    else
      @facade = TutorialFacade.new(tutorial)
    end
  end

  def index
    if current_user
      @tutorials = Tutorial.all
    else
      @tutorials = Tutorial.where("classroom = false")
    end
  end
end
