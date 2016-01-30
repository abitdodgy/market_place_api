class UserPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope
    end
  end

  def show?
    true
  end

  def update?
    user.id == record.id
  end

  def destroy?
    user.id == record.id
    # update?
  end
end
