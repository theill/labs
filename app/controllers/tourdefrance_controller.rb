# require 'json'
require 'net/http'

class TourdefranceController < ApplicationController
  def index
    rsp = Net::HTTP.get_response(URI.parse('http://tour2009.tv2.dk/livedata.php/updates/id-15.ljson'))
    data = rsp.body
    
    # result = JSON.parse(data) rescue ''
    
    respond_to do |format|
      format.html
      format.json { render :json => data}
    end
  end
end
