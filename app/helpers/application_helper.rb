module ApplicationHelper
  include Pagy::Frontend

  def nav_link_to(title, path, options = {}, &block)
    path, options = title, path if block_given?

    options[:class] = Array.wrap(options[:class])
    active_class = options.delete(:active_class) || "active"
    inactive_class = options.delete(:inactive_class) || ""

    active = if (paths = Array.wrap(options[:starts_with])) && paths.present?
      paths.any? { |path| request.path.start_with?(path) }
    else
      request.path == path
    end

    classes = active ? active_class : inactive_class
    options[:class] << classes

    if block_given?
      link_to path, options do
        block.call
      end
    else
      link_to title, path, options
    end
  end
end
