# frozen_string_literal: true

require_relative 'base'

class DelegationWithPositionalArgs < FakeControllerBase
  %w( get post put ).each do |method|
    define_method(method) do |action, options={}|
      if options.empty?
        super action
      else
        super action, options
      end
    end
  end
end
