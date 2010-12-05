module TestIt; end
module TestIt::ShouldaMacros; end
module TestIt::ShouldaMacros::Context
end


if defined? Shoulda::Context
  module Shoulda
    class Context

      alias_method :before, :setup
      alias_method :after, :teardown

    end
  end

  Shoulda::Context.extend(TestIt::ShouldaMacros::Context)
end
