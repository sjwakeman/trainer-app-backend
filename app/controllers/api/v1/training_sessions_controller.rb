class Api::V1::TrainingSessionsController < ApplicationController
    before_action :set_training_session, only: [:create,:show, :edit, :update] 

    def index
      if params[:client_id]
        #Sorts individual Client Training Sessions Index page
          @client = Client.find(params[:client_id])
          @training_sessions = @client.training_sessions.sorted
      else
      #Displays training_sessions of current_user
      #Sorts all clients Training Sessions Index page
        if params[:time] == "AM"
          @training_sessions = current_user.training_sessions.sorted.morning
        elsif params[:time] == "PM" 
          @training_sessions = current_user.training_sessions.sorted.evening
        else
          @training_sessions = current_user.training_sessions.sorted
        end
      end
    end
  
    def show
      #Duplicates def set_training_session method
      @training_session = TrainingSession.find(params[:id]) #expected: "/training_sessions/2" got: "/training_session"
    end
  
    def new
      if params[:client_id] && !Client.exists?(params[:client_id])
        redirect_to clients_path, alert: "Client not found."
      else
        @training_session = TrainingSession.new(client_id: params[:client_id])
      end
    end
  
    def create
      @training_session = current_user.training_sessions.build(training_session_params)
      #ties current_user id to @training_session.client_id
      @training_session.client.user_id = current_user.id 
          if @training_session.save
          #save client to database
          @training_session.client.save 
            redirect_to training_session_path(@training_session)
            # new server request happens, so the previous controller
            #instance is destroyed and a new controller instance is created.
        else
          render :new
          #When you render, you remain in the same controller instance
        end
    end
  
    def edit
      #def set_training_session handles this task
      @training_session = TrainingSession.find(params[:id])
    end
  
    def update
      if @training_session.update(training_session_params)
        redirect_to training_session_path(@training_session)
      else
        render :edit
      end
    end
  
    def destroy
      @training_session=TrainingSession.find(params[:id])
      @training_session.destroy
      flash[:notice] = "You have successfully cancelled the training session."
      redirect_to training_sessions_path
    end
  
    def morning
      @training_sessions = current_user.training_sessions.morning
      render :index
    end
  
    def evening
      @training_sessions = current_user.training_sessions.evening
      render :index
    end
  
    def most_recent
      @training_sessions = current_user.training_sessions.most_recent
      render :index
    end
  
    def client_most_recent
      @client = Client.find(params[:client_id])
      @training_sessions = @client.training_sessions.most_recent
      render :index
    end
  
    private
  
    def training_session_params
      params.require(:training_session).permit(:date, :client_name, :start_time, :end_time, :location, :user, :client, :booked_status, :client_id)
    end
  
    def set_training_session
      @training_session = TrainingSession.find_by(id: params[:id])
    end
  
  end
