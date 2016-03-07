module ApplicationHelper
  # Helper method to generate foundation icons
  def foundation_icon(name)
    "<i class='fi-#{name}'></i>".html_safe
  end
end
