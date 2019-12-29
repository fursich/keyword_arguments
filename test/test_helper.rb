# frozen_string_literal: true

$LOAD_PATH.unshift File.expand_path("../lib", __dir__)
$VERBOSE = true
require "keyword_arguments"

Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each { |f| require f }

require "minitest/autorun"
