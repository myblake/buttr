module ApplicationHelper
  def bootstrap_class_for flash_type
    case flash_type
      when :success
        "alert-success"
      when :error
        "alert-error"
      when :alert
        "alert-block"
      when :notice
        "alert-info"
      else
        flash_type.to_s
    end
  end

  def format_errors(errors_array)
    ("<ul><li>" + errors_array.join('</li><li>') + "</li></ul>").html_safe
  end
end
