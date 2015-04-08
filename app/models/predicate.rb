class Predicate < ActiveRecord::Base
  has_and_belongs_to_many :namespaces

  belongs_to :predicate_type

  def self.create args
    id    =  args.delete  :id
    name  =  args.delete  :name
    fn    =  args.delete  :fn

    super name: name, fn: fn, fields: args.to_json
  end
end
