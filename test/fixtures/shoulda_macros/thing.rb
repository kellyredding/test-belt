class Thing
  attr_reader :a_reader
  attr_writer :a_writer
  attr_accessor :an_accessor

  def initialize
    @a_reader = "reader"
    @a_writer = "writer"
    @an_accessor = "accessor"
  end

  def an_instance_meth
    "instance"
  end

  class << self
    def a_class_meth
      "class"
    end
  end
end
