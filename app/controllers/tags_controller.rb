class TagsController < ApplicationController
  load_and_authorize_resource     :find_by => :stub

  def index
    @tags = @tags.order(:name)
  end

  def show
    @tag = @tag.decorate
  end

  def edit
  end

  def update
    if @tag.update_attributes(tag_params)
      redirect_to @tag
    else
      render :edit
    end
  end

  private

  def tag_params
    params.require(:tag).permit([:name, :stub])
  end

end
