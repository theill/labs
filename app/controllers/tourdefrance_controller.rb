require 'json'
require 'net/http'

class TourdefranceController < ApplicationController
  def index
    rsp = Net::HTTP.get_response(URI.parse('http://tour2009.tv2.dk/livedata.php/updates/id-' + (Date.today.day + 4).to_s + '.ljson'))
    data = rsp.body
    
    respond_to do |format|
      format.html do
        @updates = ""
        
        result = JSON.parse(data) rescue ''
        unless result.blank?
          result['updates'].each do |update|
            li_id = update['time'].gsub(/ /, '_').gsub(/;/, '_').gsub(/:/, '_').gsub(/-/, '_')
            @updates += "<li id='#{li_id}'><div><b>#{update['title']}</b> <span>(#{Time.parse(update['time']).strftime('%H:%M')})</span></div>#{update['text']}</li>"
          end
        end
      end
      format.json { render :json => data }
    end
  end
end
