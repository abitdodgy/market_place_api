class UserPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope
    end
  end

  def permitted_attributes
    [:name, :email, :password]
  end

  def show?
    true
  end

  def update?
    user.id == record.id
  end

  def destroy?
    update?
  end
end
