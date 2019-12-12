class WelcomeController < ApplicationController
  def index
    @tutorials = if current_user
                   Tutorial.all.paginate(page: params[:page], per_page: 5)
                 elsif params[:tag]
                   Tutorial.tagged_with(params[:tag]).paginate(page: params[:page], per_page: 5)
                 else
                   Tutorial.where("classroom = false").paginate(page: params[:page], per_page: 5)
                 end
  end
end
