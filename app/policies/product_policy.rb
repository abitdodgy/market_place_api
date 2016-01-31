class ProductPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.where(published: true)
    end
  end

  def permitted_attributes
    [:title, :price_in_cents, :published]
  end

  def show?
    true
  end

  def create?
    true
  end
end
