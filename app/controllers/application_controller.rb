class ApplicationController < ActionController::API
    
    before_action :ensure_json_request

    # ensuring the server only accepts requests with application/json in the headers
    def ensure_json_request
        return if request.headers["Accept"] =~ /vnd\.api\+json/
        render :nothing => true, :status => 406 #returns response 406 if don't
    end

end
