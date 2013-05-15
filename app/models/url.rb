class Url < ActiveRecord::Base
  # Remember to create a migration!
  validates :original_url, :format => {:with => /https?:\/\/\w+.\w{2,}/, :message => "This is not an url"}

  def shorten
  	SecureRandom.hex(2) + '.' + (0..1).map{97.+(rand(26)).chr}.join 
  end


	def self.create_short(original)
  	current = Url.new(original_url: original)
		current.save!
		short_url = current.shorten
		current.update_attributes(:short_url => short_url)
		return current
  end

end


