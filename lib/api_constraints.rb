class APIConstraints
  def initialize(options)
  	@version = options[:version]
  	@default = options[:default]
  end

  def matches?(request)
  	(request.headers.key?('Accept')) ? request.headers['Accept'].include?("application/vnd.friends.v#{@version}") : @default
  end
end