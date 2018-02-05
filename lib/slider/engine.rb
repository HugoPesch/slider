module Slider
  class Engine < ::Rails::Engine

    isolate_namespace Slider

    require "paperclip"
    require "jquery-rails"
    require "dropzonejs-rails"
    require "image-picker-rails"

  end
end
