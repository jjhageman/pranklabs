class YouTube < Video
   include HTTParty
   format :xml
   base_uri 'gdata.youtube.com'
   default_params :output => 'xml'
   
   def self.clean_url(url)
     url.match(/http:\/\/www\.youtube\.com\/watch\?v=[^&]*/i).to_s
   end
   
   def clip_title
     response["entry"]["media:group"]["media:title"]
   end
   
   def thumbnail_url
     response["entry"]["media:group"]["media:thumbnail"][0]["url"]
   end
   
   def video_yaml
     response.to_yaml
   end
   
   def available?
     response.blank? ? false : true
   end
   
   def display_video
     <<-END
     <object width="425" height="344">
     <param name="movie" value="http://www.youtube.com/v/#{clip_id}&fs=1"</param>
     <param name="allowFullScreen" value="true"></param>
     <embed src="http://www.youtube.com/v/#{clip_id}&fs=1"
       type="application/x-shockwave-flash"
       allowfullscreen="true"
       width="425" height="344">
     </embed>
     </object>
     END
   end
   
   private
  
    def response
      self.class.get("/feeds/api/videos/#{clip_id}")
    end
  
    def clip_id
      video_url.split('?v=').last
    end
end