class TagsController < ApplicationController
  load_and_authorize_resource     :find_by => :stub

  def index
  end

  def show
    @tag = @tag.decorate
  end

  def edit
  end

  def update
    if @tag.update_attributes(params[:tag])
      redirect_to @tag
    else
      render :edit
    end
  end

end
