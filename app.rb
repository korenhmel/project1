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

	hh = {username: 'имя', phone: ' ваш телефон', datetime: ' дату и число встречи'}

	if @username.empty?|| @datetime.empty? ||@phone.empty?
		@error ="Введите #{hh.select {|key,value| params[key] == ""}.values.join(", ")}"
		return erb :visit
	else
		@succes = "#{@username}, с вами назначена встреча на #{@datetime}. Ваша персональная инф: Имя: #{@username}, телефон: #{@phone}"
		return erb :visit
	end
end

