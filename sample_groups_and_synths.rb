sg = sample_groups
sg_str = []

# convert to array of strings
for n in sg
  sg_str.push n.to_s
end
puts "#{sg_str.length} sample groups:", sg_str

synths = synth_names
synths_str = []

# convert to array of strings
for n in synths
  synths_str.push n.to_s
end
puts "#{synths_str.length} synths:", synths_str
# puts "#{synths_str.length} synths: #{synths_str * ", "}"
