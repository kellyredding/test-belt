module TestBelt; end
module TestBelt::ShouldaMacros; end
module TestBelt::ShouldaMacros::Context
end


if defined? Shoulda::Context
  module Shoulda
    class Context

      alias_method :before, :setup
      alias_method :after, :teardown

      # TODO: override described_type to use string blessed with constantize method
      # alias_method(:orig_described_type, :described_type) rescue NameError
      # def described_type
      #   self.name.gsub(/Test$/, '').constantize
      # end
      # protected :described_type

    end
  end

  Shoulda::Context.extend(TestBelt::ShouldaMacros::Context)
end
