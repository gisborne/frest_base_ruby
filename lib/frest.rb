require 'namespace'

module Frest

  Frest::RootNamespaceID = '70ce7259-dce7-418b-9242-07b66eb8ab8f'
  Frest::RootNamespace = Namespace.find_or_create_by id: RootNamespaceID, name: 'root'
end

require 'rack/lobster'
require 'converters'
require 'database_functions'

module Frest
  Page = File.read 'static/page.html'

  Main = Proc.new do |env|

    Frest.logger.debug '***' + env.inspect
    req = Rack::Request.new(env)

    path = (req['path'] || '').split('/')


    if path.length == 0
      ns = RootNamespace
    else
      ns = Namespace.find path[0]
    end

    status, type, result = ns.handle req

    Frest.convert result, type, status, req
  end


private

  def wants_javascript req
    accept = req.env['HTTP_ACCEPT']
    accept.include?('javascript')
  end

end