require 'functions'
require 'predicate'
require 'converters'

class Namespace < ActiveRecord::Base
  attr_accessor :ruby_functions, :named_functions, :fn_name_from_id
  belongs_to :parent, class_name: 'Namespace', inverse_of: :children
  belongs_to :default_presenter, class_name: 'Predicate'

  has_many :children, class_name: 'Namespace', foreign_key: :parent_id, inverse_of:  :parent

  has_and_belongs_to_many :predicates

  after_initialize :setup

  def setup
    @ruby_functions = {}
    @named_functions = {}
    @fn_name_from_id = {}
  end

  def self.get_root
    Frest::RootNamespace
  end

  def add_child id = SecureRandom.uuid, name = nil
    children.create id: id, name: name
  end

  def upward_closure
    Namespace.where "id IN (SELECT UNNEST(upward) FROM namespace_upward WHERE id = ?)", [self.id]
  end

  def get_values *names
    my_values = self.values
    my_keys = my_values.keys

    local_keys = names - my_keys
    non_local_keys = names - local_keys

    result = get_parent_values non_local_keys
    local_keys.each {|k| result[k] = my_values[k]}

    result
  end

  def get_value name
    my_values = self.values
    my_values[name] || get_value_from_parent(name)
  end

  def handle req
    if req.options?
      return handle_options req
    end

    fn = Frest.get_function id
    fn.handle req, self && return if fn

    pred = predicates.find_by id: id
    pred.handle req, self if pred

    default_handle req
  end

  def handle_options req
    fns = get_functions
    return 200, :options_list, {functions: fns}
  end

  def default_handle req
    return '200', 'text/html', self
  end

  def self.find_and_handle id, req

    ns = find(id) || RootNamespace
    ns.handle req && return if ns
  end

  private

  def get_functions
    db_fns = get_db_fns
    ruby_fns = get_ruby_fns

    db_fns_hash = {}
    db_fns.each do |f|
      db_fns_hash[f.id] = f
    end
    db_fns_hash.merge ruby_fns
  end

  def get_db_fns
    Predicate.get_functions namespace: self
  end

  def get_ruby_fns
    fns = @ruby_functions

    upward_closure.each do |ns|
      fns << ns.ruby_functions
    end

    fns
  end

  def get_parent_values names
    if parent
      parent.get_values names
    else
      {}
    end
  end

  def get_value_from_parent name
    if parent
      parent.get_value name
    else
      nil
    end
  end
end
