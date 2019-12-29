# frozen_string_literal: true

require "test_helper"

class PositionalArgumentsTest < Minitest::Test
  include KeywordTestHelper

  def setup
    # refresh caller class to make sure keyword-related warnings
    # will be output each time
    reload! :DelegationWithPositionalArgs, 'delegation_samples/positional'
    @caller = ::DelegationWithPositionalArgs.new
  end

  def test_get_method_handles_null_option_properly
    result, err = with_error do
      @caller.put(:foo)
    end

    assert_equal [:foo], result
    assert_empty err
  end

  def test_get_method_handles_empty_bracket_properly
    result, err = with_error do
      @caller.put(:foo, {})
    end

    assert_equal [:foo], result
    assert_empty err
  end

  def test_get_method_handles_keyword_arguments_properly
    result, err = with_error do
      @caller.put(:foo, bar: :baz, qux: 123)
    end

    assert_equal [:foo, { bar: :baz, qux: 123 }], result
    assert_match 'warning: Using the last argument as keyword parameters is deprecated; maybe ** should be added to the call', err
  end

  def test_get_method_handles_hash_objects_with_warnings
    result, err = with_error do
      @caller.put(:foo, { bar: :baz, qux: 123 })
    end

    assert_equal [:foo, { bar: :baz, qux: 123 }], result
    assert_match 'warning: Using the last argument as keyword parameters is deprecated; maybe ** should be added to the call', err
  end
end
