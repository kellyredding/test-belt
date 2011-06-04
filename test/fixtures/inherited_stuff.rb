module MixinStuff
  def mixin_stuff
    "from mixin"
  end
end

class SuperStuff
  def superclass_stuff
    "from superclass"
  end
end

class SubStuff
  include MixinStuff

  def subclass_stuff
    "from subclass"
  end
end
