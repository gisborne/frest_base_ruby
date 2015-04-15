require 'frest'

module Frest
  class Function
    attr_reader :name, :id, :args, :title, :from_type, :to_type, :arg_types, :arg_type_lexifications

    def initialize(
            name: null,
            namespace: Frest::RootNamespace,
            from_type: nil,
            arg_types: {},
            arg_type_lexifications: {},
            to_type:,
            title: nil,
            id:,
            **rest,
            &block)
      @name = name if name
      @id = id
      @title = title
      @to_type = to_type
      @from_type = from_type
      @arg_types = arg_types
      @args = rest if rest
      @arg_type_lexifications = arg_type_lexifications
      @title = title

      define_singleton_method :call, block if block_given

      Functions[id] = self
      namespace.ruby_functions[id] = self

      self
    end

    def handle env, ns
      puts env.inspect
    end

    def method_missing name
      return result if result = @args[name]
      nil
    end

    def to_json
      @args.merge({id: @id, title: @title, name: @name, from_type: @from_type, to_type: @to_type, arg_types: @arg_types}).to_json
    end
  end

  Functions = {}

  def self.declare_function(
      name: null,
      namespace: Frest::RootNamespace,
      from_type: nil,
      arg_types: {},
      arg_type_lexifications: {},
      title: nil,
      to_type:,
      id:,
      **rest,
      &block)
    Function.new rest.merge({
      name: name,
      namespace: namespace,
      from_type: from_type,
      arg_types: arg_types,
      arg_type_lexifications: arg_type_lexifications,
      title: title,
      to_type: to_type,
      id: id}), &block
  end

  def self.get_function id
    Functions[id]
  end
end