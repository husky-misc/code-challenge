require 'rack'

app = Proc.new do |env|
    ['200', {'Content-Type' => 'text/html'}, ['Bank Statement Receipt API Rack!']]
end

Rack::Handler::WEBrick.run(app, Port: 3000, Host: '0.0.0.0')