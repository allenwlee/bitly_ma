get '/' do
  erb :index
end

post '/urls' do
  @new_url = Url.create_short(params[:original_url])
  p @new_url
  if @new_url == false
  	erb :error
  else
	  @new_url.short_url
	  erb :index
	end
end

# e.g., /q6bda
get '/:short_url' do
  @url = Url.find_by_short_url(params[:short_url])
  old_count = @url.click_count
  @url.update_attributes(:click_count => old_count + 1)
  redirect "#{@url.original_url}"
end