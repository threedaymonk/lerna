Dir[File.expand_path('../strategies/*.rb', __FILE__)].each do |path|
  name = File.basename(path, '.rb')
  require "lerna/strategies/#{name}"
end
