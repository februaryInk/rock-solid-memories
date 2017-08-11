require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module RockSolidMemories
  class Application < Rails::Application

    config.to_prepare do
      # Load application's model / class decorators
      Dir.glob(File.join(File.dirname(__FILE__), "../app/**/*_decorator*.rb")) do |c|
        Rails.configuration.cache_classes ? require(c) : load(c)
      end

      # Load application's view overrides
      Dir.glob(File.join(File.dirname(__FILE__), "../app/overrides/*.rb")) do |c|
        Rails.configuration.cache_classes ? require(c) : load(c)
      end
    end

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # override the default behavior for input fields that fail validation (that is,
    # wrapping the field with the error in a new div with the class "field-with-error").
    # instead, just add the class "field-error" to the offending field.
    config.action_view.field_error_proc = Proc.new do |html_tag, instance|
      class_attr_index = html_tag.index 'class="'

      if class_attr_index
        html_tag.insert class_attr_index + 7, 'field-error '
      else
        html_tag.insert html_tag.index('>'), ' class="field-error"'
      end
    end

    # use the custom form builder as the default rather than the built-in one.
    config.after_initialize do
      ActionView::Base.default_form_builder = FormsHelper::CustomFormBuilder
    end
  end
end
