require 'rails_helper'
require 'spec_helper'
require "action_cable/engine"

class ApplicationCable::Connection < ActionCable::Connection::Base
    identified_by :user_id
  
    def connect
      self.user_id = request.params[:user_id]
      reject_unauthorized_connection unless user_id.present?
    end
end

describe ApplicationMailer do
    it "should be defined" do
      expect { ApplicationMailer }.not_to raise_error
    end
end

describe ApplicationJob do
  it "should be defined" do
    expect { ApplicationJob }.not_to raise_error
  end
end
