module LayoutHelper
  
  def body_class
    full_name = controller.class.to_s.underscore.
      gsub(/[\/_]/, '-').sub(/-controller/, '')

    [
      full_name,
      "#{full_name}-#{controller.action_name}",
    ].uniq.join(' ')
  end
  
  def nav_link_to(link_text, link_path, link_options = {})
    css_class = current_page?(link_path) ? 'active' : ''

    content_tag(:li, class: css_class) do
      link_to link_text, link_path, link_options
    end
  end

  def title(title)
    content_for :title, title.to_s
  end

  def main_site_url
    ENV['default_mailer_url']
  end

end