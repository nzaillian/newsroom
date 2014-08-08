module ApplicationHelper
  def controller?(*controller)
    controller.include?(params[:controller])
  end

  def action?(*action)
    action.include?(params[:action])
  end

  def alerts(options={})
    render_to_string(partial: '/common/alerts', locals: options).html_safe
  end
end
