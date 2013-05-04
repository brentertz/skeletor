module ApplicationHelper
  def body_tag_id
    format "%s-%s", controller.controller_path.parameterize, controller.action_name
  end

  def body_tag_class
    format "controller-%s action-%s", controller.controller_path.parameterize, controller.action_name
  end

  def nav_link(content, path, *args)
    options = args.extract_options!
    css_class = current_page?(path) ? 'active' : nil
    content_tag :li, class: css_class do
      link_to content, path, options
    end
  end

  # SimpleForm does not provide a helper to display base errors - those that are not associated with a specific form field.
  def display_base_errors resource
    return '' if (resource.errors.empty?) or (resource.errors[:base].empty?)
    messages = resource.errors[:base].map { |msg| content_tag(:p, msg) }.join
    html = <<-HTML
    <div class="alert alert-error alert-block">
      <button type="button" class="close" data-dismiss="alert">&#215;</button>
      #{messages}
    </div>
    HTML
    html.html_safe
  end
end
