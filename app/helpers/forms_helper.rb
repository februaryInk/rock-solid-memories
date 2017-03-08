module FormsHelper
  class CustomFormBuilder < ActionView::Helpers::FormBuilder
    
    def error_message(attribute)
    
      if @object.errors[attribute].present?
        @template.content_tag(:p, { :class => 'error-message' }) do
          @object.errors.messages[attribute].join(', ')
        end
      end
    end
  end
end
