module DamagesHelper
  def health_bar_color_class(health)
    case health
    when 1..30
      color = "alert"
    when 31 .. 70
      color = "warning"
    when 71..100
      color = "success"
    end
    color
  end
end
