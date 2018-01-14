module Services
  class Store
    def initialize(params)
      @params = params
    end

    def call
      validate_params

      ips = ip_list.map { |ip| ::Services::Utils::IpParser.new(ip).call }

      ips.each { |item| item.save! }
    end

    private
    
    def validate_params
      fail ::Exceptions::MalformedInputError if @params['ip_list'].blank?
    end

    def ip_list
      @ip_list ||= @params['ip_list']  
    end
  end
end