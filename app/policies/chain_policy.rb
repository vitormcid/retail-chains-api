 class ChainPolicy
    attr_reader :user, :chain

    def initialize(user, chain)
      raise Pundit::NotAuthorizedError, "only administrators can perform this action" unless user.role?(:admin)     
    end

    def method_missing(name, *args)
      true
    end


  end