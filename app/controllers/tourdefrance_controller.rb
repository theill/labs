require 'json'
require 'net/http'

class TourdefranceController < ApplicationController
  def index
    rsp = Net::HTTP.get_response(URI.parse('http://tour2009.tv2.dk/livedata.php/updates/id-' + (Date.today.day + 3).to_s + '.ljson'))
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
      format.json do
        result = JSON.parse(data) rescue ''
        unless result.blank?
          latest_few_minutes = -3.minutes.from_now
          result['updates'] = result['updates'].delete_if { |a| a['time'].to_datetime < latest_few_minutes }
        end
        render :json => result.to_json
      end
    end
  end
end
