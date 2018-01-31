require 'json'
require 'open-uri'

class OfficesController < ApplicationController

  def index
    if params[:postcode].present?
      @postcode = params[:postcode]
      url = "https://api.postcodes.io/postcodes/#{@postcode}"
      postcode_api = open(url).read
      address = JSON.parse(postcode_api)
      @search_lng = address['result']['longitude']
      @search_lat = address['result']['latitude']
      @search_coords = [@search_lng,@search_lat]
      @offices = Office.all
    else
      @offices = Office.all
    end
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

  helper_method :distance

  def distance(loc1, loc2)
    rad_per_deg = Math::PI/180  # PI / 180
    rkm = 6371                  # Earth radius in kilometers
    rm = rkm * 1000             # Radius in meters

    dlat_rad = (loc2[0]-loc1[0]) * rad_per_deg  # Delta, converted to rad
    dlon_rad = (loc2[1]-loc1[1]) * rad_per_deg

    lat1_rad, lon1_rad = loc1.map {|i| i * rad_per_deg }
    lat2_rad, lon2_rad = loc2.map {|i| i * rad_per_deg }

    a = Math.sin(dlat_rad/2)**2 + Math.cos(lat1_rad) * Math.cos(lat2_rad) * Math.sin(dlon_rad/2)**2
    c = 2 * Math::atan2(Math::sqrt(a), Math::sqrt(1-a))

    ((rm * c) / 1000).round(2) # Delta in km
  end

  private

  def offices_params
    params.require(:office).permit(:name, :postcode)
  end

end
