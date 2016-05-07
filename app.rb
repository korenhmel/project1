require 'rubygems'
require 'sinatra'
require 'haml'
require 'pony'
# require 'sinatra/reloader'

get '/' do
	erb "Hello! <a href=\"https://github.com/bootstrap-ruby/sinatra-bootstrap\">Original</a> pattern has been modified for <a href=\"http://rubyschool.us/\">Ruby School</a>"			
end

get '/about' do
  @error = 'smth went wrong!!!'
	erb :about
end

get '/contacts' do
haml :contacts
end

get '/visit' do
	erb :visit
end
post '/contact' do
	name = params[:name]
		mail = params[:mail]
			body = params[:body]
				Pony.mail(:to => 'koren.hmel@gmail.com', :from => mail, :subject => 'art inquiry from'+ name, :body => body)
  haml :contacts
end
post '/visit' do

	@username = params[:username]
	@phone = params[:phone]
	@datetime = params[:datetime]
	@barber = params[:barber]
	@color = params[:color]


  # if @username.empty?
  #   @error = "введите имя"
  #   erb :visit
  # end
  #
  # if @phone.empty?
  #   @error = "введите телефон"
		# erb :visit
  # end
  # if @datetime.empty?
  #   @error = "введите дату встречи"
  #   erb :visit
  # end



	# хеш
	# hh = { 	:username => 'Введите имя',
	# 		:phone => 'Введите телефон',
	# 		:datetime => 'Введите дату и время' }
  #
	# @error = hh.select {|key,_| params[key] == ""}.values.join(", ")


  hh = {username: ' имя', phone: 'ваш телефон', datetime: ' дату и число встречи'}
  # hh.each do |key, value|
  #   if params[key].empty?
  #   @error = hh[key]
  #     erb :visit
  #   end
  # end

  @error ="Введите #{hh.select {|key,value| params[key] == ""}.values.join(", ")}"

	if @error != ''
		return erb :visit
	end

	erb "OK, username is #{@username}, #{@phone}, #{@datetime}, #{@barber}, #{@color}"

end
