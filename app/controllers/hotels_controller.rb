class HotelsController < ApplicationController
  include HTTParty

  base_uri 'murmuring-citadel-60488.herokuapp.com'

  def index
    response = if params[:search]
      self.class.get('/search', { body: { words: params[:search] } })
    else
      self.class.get('/')
    end

    @hotels = if response.code == 404
      []
    else
      JSON.parse(response.body, object_class: Hotel)
    end

    session[:hotels] = @hotels if params[:search].blank?

    @hotels
  end

  def show
    hash = session[:hotels].find{ |hotel| hotel['id'].to_s == params[:id] }
    @hotel = OpenStruct.new(id: hash['id'], name: hash['name'], address: hash['address'], star_rating: hash['star_rating'], accomodation_type: hash['accomodation_type'])
  end

  def new
    @hotel = Hotel.new
  end

  def edit
    hash = session[:hotels].find{ |hotel| hotel['id'].to_s == params[:id] }
    @hotel = Hotel.new(name: hash['name'], address: hash['address'], star_rating: hash['star_rating'], accomodation_type: hash['accomodation_type'])
  end

  def create
    response = self.class.post('/hotels', { body: hotel_params })

    respond_to do |format|
      if response.code == 201
        format.html { redirect_to hotels_url, notice: 'Hotel was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  def update
    response = self.class.put("/hotels/#{ params['id'] }", { body: hotel_params })

    respond_to do |format|
      if response.code == 200
        @hotel = JSON.parse(response.body, object_class: Hotel)

        format.html { redirect_to @hotel, notice: 'Hotel was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    response = self.class.delete("/hotels/#{ params['id'] }")

    respond_to do |format|
      if response.code == 200
        format.html { redirect_to hotels_url, notice: 'Hotel was successfully destroyed.' }
        format.json { head :no_content }
      end
    end
  end

  def search
    response = self.class.get('/search', { body: params })

    @hotels = JSON.parse(response.body, object_class: Hotel)

    respond_to do |format|
      if response.code == 201
        @hotel = OpenStruct.new(hotel_params)

        format.html { redirect_to @hotel, notice: 'Hotel was successfully created.' }
      end
    end
  end


  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def hotel_params
      params.require(:hotel).permit(:name, :address, :star_rating, :accomodation_type)
    end

    # def hotel
    #   hash = session[:hotels].find{ |hotel| hotel['id'].to_s == params[:id] }
    #   @hotel = OpenStruct.new(name: hash['name'], address: hash['address'], star_rating: hash['star_rating'], accomodation_type: ['accomodation_type'])
    # end

end
