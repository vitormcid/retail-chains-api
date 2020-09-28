 class VisitorPolicy
    attr_reader :user, :visitor

    def initialize(user, visitor)
      raise Pundit::NotAuthorizedError, "only administrators can perform this action" unless user.role?(:admin)     
    end

    def method_missing(name, *args)
      true
    end


  end