require File.expand_path("../modular.rb", __FILE__)

run Rack::URLMap.new(
  "/" => Public,
  "/private" => Private
)
