module Error
  module ErrorHandler
  	def self.included(myClass)
  	  myClass.class_eval do
        rescue_from ActiveRecord::RecordInvalid, with: :record_invalid
        rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  	  end
  	end

  	private

  	def record_invalid(err)
  	  render json: {status: :bad_request, error: err.to_s, message: 'Invalid parameter'}, status: :bad_request
  	end

    def record_not_found(err)
      render json: {status: :not_found, error: err.to_s, message: 'Record not found'}, status: :not_found
    end
  end
end