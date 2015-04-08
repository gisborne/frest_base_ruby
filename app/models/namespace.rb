require 'functions'
require 'predicate'

class Namespace < ActiveRecord::Base
  belongs_to :parent, class_name: 'Namespace', inverse_of: :children

  has_many :children, class_name: 'Namespace', foreign_key: :parent_id, inverse_of:  :parent

  has_and_belongs_to_many :predicates

  def self.get_root
    Frest::RootNamespace
  end

  def add_child id = SecureRandom.uuid, name = nil
    children.create id: id, name: name
  end

  def upward_closure_ids
    search_sql = <<SQL
WITH RECURSIVE
  ns AS
(SElECT
      id AS id,
      parent_id,
      ARRAY[id] AS upward
    FROM
      namespaces
  UNION ALL
    SELECT
      ns.id,
      n_parent.parent_id,
      ns.upward || n_parent.id
    FROM
      ns JOIN
      namespaces AS n_parent ON (ns.parent_id = n_parent.id)
    WHERE
      NOT n_parent.id = ANY(ns.upward))
SELECT
  upward
FROM
  ns
WHERE
  id = '#{self.id}'
ORDER BY ARRAY_LENGTH(upward, 1) DESC LIMIT 1
SQL
    ActiveRecord::Base.connection.select_value(search_sql, [self.id])[1..-2].split(',')
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
    req['wants_javascript'] = wants_javascript(req)

    fn = Frest.get_function id
    fn.handle req, self && return if fn

    pred = predicates.find_by id: id
    pred.handle req, self if pred

    default_handle req
  end

  def default_handle req
    ['200', {'Content-Type' => 'text/html'}, [Frest::Page]]
  end

  def self.find_and_handle id, req

    ns = find(id) || RootNamespace
    ns.handle req && return if ns
  end

  private

  def wants_javascript req
    accept = req.env['HTTP_ACCEPT']
    accept.include?('javascript')
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
