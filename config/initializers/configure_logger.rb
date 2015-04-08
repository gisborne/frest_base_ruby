Frest.logger.formatter = proc do |severity, datetime, progname, msg|
  "[#{severity}] #{msg}\n"
end
Frest.logger.level = (Frest.env == 'production' ? Logger::DEBUG : Logger::INFO)