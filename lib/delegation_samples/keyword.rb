# frozen_string_literal: true

require_relative 'base'

class DelegationWithKeywordArgs < FakeControllerBase
  %w( get post put ).each do |method|
    define_method(method) do |action, options={}|
      if options.empty?
        super action
      else
        super action, **options # delegating with double-splat
      end
    end
  end
end
