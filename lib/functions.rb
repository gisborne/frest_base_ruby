module Frest
  class Function
    def initialize name: null, id:, **rest, &block
      @name = name if name
      @id = id
      @args = rest if rest
      @block = block if block
    end

    def call **args
      block.call args
    end

    def handle env, ns
      puts env.inspect
    end
  end

  Functions = {}

  def declare_function name: null, id:, **rest, &block
    fn = Function.new rest.merge({name: name, id: id}), &block
    Functions[id] = fn
    Functions[name] = fn if name
  end

  def self.get_function id
    Functions[id]
  end
end