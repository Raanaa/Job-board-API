class JobPolicy < ApplicationPolicy
    attr_reader :user, :job
  
    def initialize(user, job)
      @user = user
      @job = job
    end
  
    def create?
        user.admin?
    end

    def update?
        user.admin?
      end

    def destroy?
        user.admin?
    end

end