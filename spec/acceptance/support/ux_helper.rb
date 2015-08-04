class UxHelper
  include CapybaraHelpers
  attr_reader :selector
  def initialize(selector)
    @selector = selector
  end

  def element
    find selector
  end
end
