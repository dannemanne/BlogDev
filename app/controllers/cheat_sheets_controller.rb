class CheatSheetsController < ApplicationController
  load_and_authorize_resource

  def index
    @cheat_sheet_groups = @cheat_sheets.group_by(&:category_stub).sort
  end

  def new
  end

  def create
    if @cheat_sheet.save
      redirect_to :action => :index
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @cheat_sheet.update_attributes(cheat_sheet_params)
      redirect_to :action => :index
    else
      render :edit
    end
  end

  def destroy
    if @cheat_sheet.destroy
      redirect_to :action => :index
    else
      render :edit
    end
  end

private
  def cheat_sheet_params
    params.require(:cheat_sheet).permit(:title, :category, :body, :parsed_body)
  end

end
