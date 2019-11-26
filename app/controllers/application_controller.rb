class ApplicationController < ActionController::API
    include DeviseTokenAuth::Concerns::SetUserByToken
    
    before_action :ensure_json_request

    # ensuring the server only accepts requests with vnd.api+json in the headers - JSON API specification
    def ensure_json_request
        unless request.headers["Accept"] =~ /vnd\.api\+json/
            render :nothing => true, :status => 406 #returns response 406 if don't
        else
            unless request.get?
                return if request.headers["Content-Type"] =~ /vnd\.api\+json/ 
                render :nothing => true, :status => 415 #returns response 415 if don't
            end
        end
    end

end
