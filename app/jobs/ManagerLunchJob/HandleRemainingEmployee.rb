module ManagerLunchJob
  class HandleRemainingEmployee
    include Sidekiq::Job

    def perform(employee_id)      
      ManagerLunch::HandleRemainingEmployees.call(employee_id)
    end    
  end
end