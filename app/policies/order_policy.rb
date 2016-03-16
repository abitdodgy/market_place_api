class OrderPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.where(user: user)
    end
  end

  alias_method :order, :record

  def permitted_attributes
    [product_ids: []]
  end

  def show?
    user.id == order.user_id
  end

  def create?
    true
  end
end
