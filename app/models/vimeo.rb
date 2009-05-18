class Vimeo < Video
  include HTTParty
  format :json
  base_uri 'vimeo.com'
  default_params :output => 'json'
  
  def get_by_url
    @id = clip_id
    @response = get('/api/oembed.json/', :query => {:url => "http://vimeo.com/#{@id}"})
  end
  
  def clip_id
    video_url.split('/').last
  end
end