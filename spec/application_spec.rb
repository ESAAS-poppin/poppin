require 'rails_helper'
require 'spec_helper'

class ApplicationCable::Connection < ActionCable::Connection::Base
    identified_by :user_id
  
    def connect
      self.user_id = request.params[:user_id]
      reject_unauthorized_connection unless user_id.present?
    end
end