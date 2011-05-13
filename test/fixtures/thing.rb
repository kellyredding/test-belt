class Thing
  attr_reader :reader1, :reader2, :reader3
  attr_writer :writer1, :writer2, :writer3
  attr_accessor :accessor1, :accessor2, :accessor3

  def initialize
    @reader1, @reader2, @reader3 = [1, 2, 3]
    @writer1, @writer2, @writer3 = [1, 2, 3]
    @accessor1, @accessor2, @accessor3 = [1, 2, 3]
  end

  def an_instance_meth
    "instance"
  end
  alias_method :instance1, :an_instance_meth
  alias_method :instance2, :an_instance_meth

  class << self
    def a_class_meth
      "class"
    end
    alias_method :class1, :a_class_meth
    alias_method :class2, :a_class_meth
  end
end
