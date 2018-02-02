require 'json'
require 'open-uri'

class OfficesController < ApplicationController

  def index
    if params[:postcode].present?
      @postcode = params[:postcode].gsub(/\s+/, "")
      url = "https://api.postcodes.io/postcodes/#{@postcode}"
      postcode_api = open(url).read
      address = JSON.parse(postcode_api)
      @search_lng = address['result']['longitude']
      @search_lat = address['result']['latitude']
      @search_coords = [@search_lng,@search_lat]
      @all_offices = Office.where.not(latitude: nil, longitude: nil)
      @offices = []
      @all_offices.each do |office|
        office_element = {}
        office_coords = [office.longitude, office.latitude]
        distance = distance(@search_coords, office_coords)
        if distance <= params[:radius].to_f
          office_element[:office] = office
          office_element[:distance] = distance
          @offices << office_element
        end
      end
      @markers = @offices.map do |office|
        {
          lat: office[:office].latitude,
          lng: office[:office].longitude
        }
      end
    else
      @offices = Office.where.not(latitude: nil, longitude: nil)
      @markers = @offices.map do |office|
        {
          lat: office.latitude,
          lng: office.longitude
        }
      end
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

  def distance(loc1, loc2)
    rad_per_deg = Math::PI/180  # PI / 180
    rm = 3959                  # Earth radius in miles

    dlat_rad = (loc2[0]-loc1[0]) * rad_per_deg  # Delta, converted to rad
    dlon_rad = (loc2[1]-loc1[1]) * rad_per_deg

    lat1_rad, lon1_rad = loc1.map {|i| i * rad_per_deg }
    lat2_rad, lon2_rad = loc2.map {|i| i * rad_per_deg }

    a = Math.sin(dlat_rad/2)**2 + Math.cos(lat1_rad) * Math.cos(lat2_rad) * Math.sin(dlon_rad/2)**2
    c = 2 * Math::atan2(Math::sqrt(a), Math::sqrt(1-a))

    (rm * c).round(1) # Delta in miles
  end

  def self.sorted_by_percentage_correct
    Office.all.sort_by(&:percentage_correct)
  end

  private

  def offices_params
    params.require(:office).permit(:name, :postcode)
  end

end
