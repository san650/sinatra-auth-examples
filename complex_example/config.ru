[
  "user",
  "protected",
  "public",
  "auth",
  "admin"
].each do |name|
  require File.expand_path("../app/#{name}.rb", __FILE__)
end

run Rack::URLMap.new(
  "/" => Public,
  "/login" => Auth,
  "/admin" => Admin
)
