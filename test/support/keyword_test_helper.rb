# frozen_string_literal: true

module KeywordTestHelper

  # Ruby recalls the caller/the callee combination and supresses keyword warnings
  # from the second time violation is detected, which makes our tests non-deterministic
  # https://github.com/ruby/ruby/blob/819b604037c317d2b53a1aaca67aef25da2d5ec9/vm_args.c#L595
  # we need to somehow reload klass (or redefine tested methods) in order to
  # test keyword-related warnings deterministically
  # example: https://github.com/ruby/ruby/commit/191ce5344ec42c91571f8f47c85be9138262b1c7#diff-5dbe613f725860801fa4c2c812b1d181R316-R326

  def reload!(klass, load_path)
    loaded_file = "#{load_path}.rb" unless load_path.end_with? '.rb'

    Object.send(:remove_const, klass)
    $LOADED_FEATURES.delete_if do |real_path|
      real_path.end_with? loaded_file
    end

    require load_path
  end

  def with_error
    result = nil

    _out, err = capture_subprocess_io do
      result = yield
    end

    [result, err]
  end
end
