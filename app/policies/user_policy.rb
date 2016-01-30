class UserPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope
    end
  end

  def update?
    user.id == record.id
  end

  def destroy?
    update?
  end
end
