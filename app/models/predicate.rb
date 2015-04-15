require 'frest'
class Predicate < ActiveRecord::Base
  has_and_belongs_to_many :namespaces

  belongs_to :predicate_type

  def self.create args
    id    =  args.delete  :id
    name  =  args.delete  :name
    fn    =  args.delete  :fn

    super name: name, fn: fn, fields: args.to_json
  end

  def self.get_functions(namespace: nil)
    result = where "fn IS NOT NULL"

    #Look in the upward closure of namespace to see if we're defined there
    if namespace
      if namespace.is_a? Namespace
        ns_id = namespace.id
      else
        ns_id = namespace
      end
      result = result.where "
          EXISTS (SELECT 1 FROM namespaces_predicates WHERE(
              predicate_id = predicates.id AND
              namespace_id IN (SELECT UNNEST(upward) FROM namespace_upward WHERE id = '#{ns_id}')))"
    end

    result
  end
end
