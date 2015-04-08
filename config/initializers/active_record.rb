ActiveRecord::Base.logger = Frest.logger
ActiveRecord::Base.establish_connection(
  adapter: 'postgresql',
  host: 'localhost',
  username: 'gisborne',
  password: '9455word',
  database: 'frest_development',
  encoding: 'utf8'
)