# frozen_string_literal: true

require "test_helper"

class ComparisonTest < Minitest::Test
  include KeywordTestHelper

  def setup
    @delegation_positional_args = DelegationWithPositionalArgs.new
    @delegation_keyword_args    = DelegationWithKeywordArgs.new
  end

  def test_get_method_handles_empty_bracket_with_warnings
    result_1, _err = with_error do
      @delegation_positional_args.put(:foo, {})
    end

    result_2, _err = with_error do
      @delegation_keyword_args.put(:foo, {})
    end

    assert_equal result_1, result_2
  end

  def test_get_method_handles_null_option_properly
    result_1, _err = with_error do
      @delegation_positional_args.put(:foo)
    end

    result_2, _err = with_error do
      @delegation_keyword_args.put(:foo)
    end

    assert_equal result_1, result_2
  end

  def test_get_method_handles_keyword_arguments_properly
    result_1, _err = with_error do
      result_1 = @delegation_positional_args.put(:foo, bar: :baz, qux: 123)
    end

    result_2, _err = with_error do
      @delegation_keyword_args.put(:foo, bar: :baz, qux: 123)
    end

    assert_equal result_1, result_2
  end

  def test_get_method_handles_hash_objects_with_warnings
    result_1, _err = with_error do
      @delegation_positional_args.put(:foo, { bar: :baz, qux: 123 })
    end

    result_2, _err = with_error do
      @delegation_keyword_args.put(:foo, { bar: :baz, qux: 123 })
    end

    assert_equal result_1, result_2
  end
end
