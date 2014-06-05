get '/' do
  erb :index
end

post '/new' do
  @note = Note.create({title: params[:title], content: params[:content], user_id: session[:user_id]})
  redirect "/note/#{@note.id}"
end

post '/authenticate' do
  if params[:password] == User.find_by_username(params[:username]).password
    session[:user_id] = User.find_by_username(params[:username]).id
    redirect '/'
  else
    redirect '/'
  end
end

post '/logout' do
  session[:user_id] = nil
  redirect '/'
end

get '/edit/:id' do
  @note = Note.find(params[:id])
  erb :edit
end

put '/edit/:id' do
  Note.find(params[:id]).update_attributes(title: params[:title], content: params[:content])
  redirect "/note/#{params[:id]}"
end

get '/newuser' do
  erb :newuser
end

post '/user' do
  User.create({username: params[:username], password: params[:password]})
  redirect '/'
end

get '/user/:id' do
  erb :userposts
end

get '/note/:id' do
  @note = Note.find(params[:id])
  erb :note
end
