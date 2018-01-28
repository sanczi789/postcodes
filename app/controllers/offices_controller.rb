class OfficesController < ApplicationController

    def index
    @offices = Office.all
  end

  def new
    @office = Office.new
  end

  def create
    @office = Office.new(offices_params)
    if @office.save
      redirect_to root_path
    else
      render "new"
    end
  end

  private

  def offices_params
    params.require(:office).permit(:name, :postcode)
  end

end
