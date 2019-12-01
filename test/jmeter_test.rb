require 'ruby-jmeter'

test do
  with_json
  threads 1, loops: 100 do
    get name: 'get_bank_statements',
        url: ''
  end
end.run