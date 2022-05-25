# require 'json' # works without this, so commented out
file = File.read(get(:sp_path)+'SonicPi_tests\json\sample_data.json')
data_hash = JSON.parse(file)
puts data_hash.keys[2]
puts data_hash['books']
puts data_hash['books'].keys[0]
puts data_hash['books']['2']
