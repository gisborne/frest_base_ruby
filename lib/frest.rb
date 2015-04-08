require 'rack/lobster'
module Frest
  require 'namespace'

  RootNamespaceID = '70ce7259-dce7-418b-9242-07b66eb8ab8f'
  RootNamespace = Namespace.find_or_create_by id: RootNamespaceID, name: 'root'

  Page = File.read 'static/page.html'

  Main = Proc.new do |env|

    logger.debug env
    req = Rack::Request.new(env)
    path = (req['path'] || '').split('/')


    if path.length == 0
      RootNamespace.handle req
    else
      Namespace.find_and_handle req
    end
  end
end