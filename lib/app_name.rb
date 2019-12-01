#Rack Middleware for the API
class AppName 
    def initialize(app, app_name)
        @app = app
        @app_name = app_name
    end

    def call(env)
        if env["ORIGINAL_FULLPATH"] == "/"
            ['200', {'Content-Type' => 'text/html'}, ['Bank Statement Receipt API - correct path /v1/bank_statements']]
        else
            status, headers, response = @app.call(env)
            headers.merge!({'X-App-Name' => "#{@app_name}"})
            if status==304
                [status, headers, []]
            else
                [status, headers, [response.body]]
            end
        end
    end
end
