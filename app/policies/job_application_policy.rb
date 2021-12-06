class JobApplicationPolicy < ApplicationPolicy
    attr_reader :user, :job_application
  
    def initialize(user, job_application)
      @user = user
      @job = job_application
    end
  
    def create?
        !user.admin?
    end

    def index?
        user.admin?
      end

    def show?
        user.admin?
    end

end