module Frest
  class DefaultPresenter
    def call target:, type:, req:
      if target.is_a? String
        ['200', {'Content-Type' => type}, [target]]
      else
        ['200', {'Content-Type' => type}, [Page]]
      end
    end
  end

  class OptionsPresenter
    def call(target:, type:, req:)
      [200, {'Content-Type' => 'text/html'}, ["
          var json = #{target.to_json};frest.displayOptions(json)"]]
    end
  end

  def self.get_default_presenter
    @default_presenter ||= DefaultPresenter.new
  end

  def self.get_options_presenter
    @options_presenter ||= OptionsPresenter.new
  end

  def self.convert arg, type, status, req
    if req.options?
      get_options_presenter.call target: arg, type: type, req: req
    else
      default_presenter = arg.try(:default_presenter) || get_default_presenter

      default_presenter.call target: arg, type: type, req: req
    end
  end
end