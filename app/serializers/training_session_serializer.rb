class TrainingSessionSerializer < ActiveModel::Serializer
  belongs_to :user
  belongs_to :client
  attributes :id, :date, :client_name, :start_time, :end_time, :location, :user, :client, :booked_status, :client_id
end
