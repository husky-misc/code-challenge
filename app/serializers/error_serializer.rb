module ErrorSerializer
    def self.serialize(errors) # standard errors
        return if errors.nil? # return null if has no errors

        # list all errors
        json = {}
        new_hash = errors.to_hash.map do |k, v|
            v.map do |msg|
                { id: k, title: msg } # according to JSON API specification
            end
        end.flatten # formatting response
        json[:erros] = new_hash
        json
    end
end