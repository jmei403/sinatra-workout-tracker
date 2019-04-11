class WorkoutsController < ApplicationController

  get '/workouts/new' do
    redirect_if_not_logged_in
    erb :"workouts/new"
  end

  post '/workouts' do
    redirect_if_not_logged_in
    @workout = current_user.workouts.new(params[:workout])
    if @workout.save
      redirect "/workouts/#{@workout.id}"
    else
      redirect "/workouts/new"
    end
  end

  get '/workouts/:id' do
    redirect_if_not_logged_in
    @workout = Workout.find(params[:id])
    erb :"workouts/show"
  end

  get '/workouts/:id/edit' do
    redirect_if_not_logged_in
    @workout = Workout.find(params[:id])
    if @workout.user == current_user
      erb :"workouts/edit"
    else
      redirect "/users/#{@workout.user.slug}"
    end
  end

  patch '/workouts/:id' do
    redirect_if_not_logged_in
    @workout = Workout.find(params[:id])
    @workout.update(params[:workout]) if @workout.user == current_user
    redirect "/workouts/#{@workout.id}"
  end

  delete "/workouts/:id" do
    redirect_if_not_logged_in
    @workout = Workout.find(params[:id])
    @workout.destroy if @workout.user == current_user
    redirect "/users/#{@workout.user.slug}"
  end

end