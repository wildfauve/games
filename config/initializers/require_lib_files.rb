Dir[Rails.root + 'lib/**/*.rb'].each do |file|
  require_dependency file
end