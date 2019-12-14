yml = ERB.new(File.read(Rails.root.join('config/database.yml')))
print yml.result
