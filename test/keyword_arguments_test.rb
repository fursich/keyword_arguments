# frozen_string_literal: true

require "test_helper"

class KeywordArgumentsTest < Minitest::Test
  include KeywordTestHelper

  def setup
    # refresh caller class to make sure keyword-related warnings
    # will be output each time
    reload! :DelegationWithKeywordArgs, 'delegation_samples/keyword'
    @caller = DelegationWithKeywordArgs.new
  end

  def test_get_method_handles_null_option_properly
    result, err = with_error do
      result = @caller.put(:foo)
    end

    if RUBY_VERSION < "2.7"
      assert_equal [:foo, {}], result
    else
      assert_equal [:foo], result
    end
    assert_empty err
  end

  def test_get_method_handles_empty_bracket_with_warnings
    result, err = with_error do
      result = @caller.put(:foo, {})
    end

    if RUBY_VERSION < "2.7"
      assert_equal [:foo, {}], result
    else
      assert_equal [:foo], result
    end
    assert_empty err
  end

  def test_get_method_handles_keyword_arguments_properly
    result, err = with_error do
      result = @caller.put(:foo, bar: :baz, qux: 123)
    end

    assert_equal [:foo, { bar: :baz, qux: 123 }], result
    assert_empty err
  end

  def test_get_method_handles_hash_objects_with_warnings
    result, err = with_error do
      result = @caller.put(:foo, { bar: :baz, qux: 123 })
    end

    assert_equal [:foo, { bar: :baz, qux: 123 }], result
    assert_empty err
  end
end
