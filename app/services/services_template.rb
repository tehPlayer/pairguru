class ServicesTemplate
  attr_accessor :results

  class << self
    def perform!(*args)
      new(*args).perform!
    end
  end

  def perform!
    raise 'Abstract method call: perform!'
  end
end