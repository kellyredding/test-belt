module TestBelt::Utils
  class << self

    def local_public_instance_methods(klass)
      methods = klass.public_instance_methods
      while (klass.superclass)
        methods -= (klass = klass.superclass).public_instance_methods
      end
      methods
    end

  end
end
