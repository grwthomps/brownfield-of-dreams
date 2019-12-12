class TutorialsController < ApplicationController
  def show
    tutorial = Tutorial.find(params[:id])
    if tutorial.classroom == true && !current_user
      flash[:error] = "Please log in to see this content"
      redirect_to '/'
    else
      @facade = TutorialFacade.new(tutorial, params[:video_id])
    end
  end

  def index
    @tutorials = if current_user
                   Tutorial.all
                 else
                   Tutorial.where("classroom = false")
                 end
  end
end
