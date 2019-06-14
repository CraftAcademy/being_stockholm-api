module DecodeImageService
  def self.attach_image(img, target)

    if Rails.env == "test"
      image = img
    else
      image = split_base64(img[0])
    end
    decoded_data = Base64.decode64(image[:data])
    io = StringIO.new
    io.puts(decoded_data)
    io.rewind
    target.attach(io: io, filename: "base.#{image[:extension]}")
  end

  private 

  def self.split_base64(uri_str)
    if uri_str =~ /^data:(.*?);(.*?),(.*)$/
      uri = {}
      uri[:type] = Regexp.last_match(1) # "image/gif"
      uri[:encoder] = Regexp.last_match(2) # "base64"
      uri[:data] = Regexp.last_match(3) # data string
      uri[:extension] = Regexp.last_match(1).split('/')[1] # "gif"
      uri
    end
  end
end  