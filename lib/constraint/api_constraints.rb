module Constraint
  class Api_constraints
    def initialize(options)
    	@version = options[:version]
    	@default = options[:default]
    end
  
    def matches?(request)
    	result = (request.headers.key?('Accept') && request.headers['Accept'].include?("application/vnd.friends.v")) ?
    			 request.headers['Accept'].include?("application/vnd.friends.v#{@version}") : @default
    end
  end
end