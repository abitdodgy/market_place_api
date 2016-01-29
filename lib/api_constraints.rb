class APIConstraints
  def initialize(version:, default: false)
    @version = version
    @default = default
  end

  def matches?(request)
    @default || request.headers['Accept'].include?("application/vnd.marketplace.v#{@version}")
  end
end
