# frozen_string_literal: true

class FakeControllerBase
  def get(action, **args)
    [action, **args]
  end

  def put(action, **args)
    [action, **args]
  end

  def post(action, **args)
    [action, **args]
  end
end
