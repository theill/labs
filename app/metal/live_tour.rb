# Allow the metal piece to run in isolation
require(File.dirname(__FILE__) + "/../../config/environment") unless defined?(Rails)

require 'json'
require 'net/http'
require 'time'

$KCODE = 'u'

class LiveTour
  def self.call(env)
    if env["PATH_INFO"] =~ /^\/livetour/
      rsp = Net::HTTP.get_response(URI.parse('http://tour2009.tv2.dk/livedata.php/updates/id-14.ljson'))
      data = rsp.body
      
      result = JSON.parse(data) rescue ''
      unless result.blank?
        out = "<html><head><meta http-equiv=\"Content-type\" content=\"text/html; charset=utf-8\" /><meta name=\"viewport\" content=\"width=320,initial-scale=1,user-scalable=no\" /><title>Tour de France live opdateringer til mobiltelefoner</title></head><body><ul>"
        result['updates'].each do |update|
          out += "<li><b>#{update['title']} (#{Time.parse(update['time']).strftime('%H:%M')})</b><br />\n#{update['text']}<br /><br />\n\n</li>"
        end
        out += "</ul><script type=\"text/javascript\">var gaJsHost = ((\"https:\" == document.location.protocol) ? \"https://ssl.\" : \"http://www.\");document.write(unescape(\"%3Cscript src='\" + gaJsHost + \"google-analytics.com/ga.js' type='text/javascript'%3E%3C/script%3E\"));</script><script type=\"text/javascript\">try {var pageTracker = _gat._getTracker(\"UA-617778-13\");pageTracker._trackPageview();} catch(err) {}</script>"
        out += '</body></html>'
      else
        out = 'Ingen nyheder for dagens etape.'
      end
      
      [200, {"Content-Type" => "text/html"}, [out]]
    else
      [404, {"Content-Type" => "text/html"}, ["Not Found"]]
    end
  end
end