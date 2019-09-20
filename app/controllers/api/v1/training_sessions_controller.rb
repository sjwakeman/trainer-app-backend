class Api::V1::TrainingSessionsController < ApplicationController
    before_action :find_training_session, only: [:update]
    def index
    @training_sessions = TrainingSession.all
        render json: @training_sessions
    end
 
    def update
    @training_session.update(training_session_params)
        if @training_session.save
            render json: @training_session, status: :accepted
        else
            render json: { errors: @training_session.errors.full_messages }, status: :unprocessible_entity
        end
    end
    
    private
    
    def training_session_params
    params.require(:training_session).permit(:date, :client_name, :start_time, :end_time, :location, :user, :client, :booked_status, :client_id)
    end
    
    def find_training_session
    @note = TrainingSession.find(params[:id])
    end

end
