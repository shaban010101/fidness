# coding: utf-8
module SessionHelper
  def select_options_html(trainer)
    content_tag(:select, { name: :option, id: :option, class: 'form-control', prompt: 'Select an option' }) do    
      Option.all.each do |option|
        concat(content_tag(:option, option.name, { value: option.id, data: { price: total_session_cost(option, trainer), session_cost: per_session_cost(trainer, option, discount_percentage: session_discount[option.number_of_sessions.to_s])}}))
      end
    end
  end

  def session_discount
    {
      '0.5' => 0.60,
      '10.0' => 1,
      '5.0' => 0.92,
      '10.0' => 0.84,
      '15.0' => 0.76
    }
  end

  def sessions_cost(trainer, option, discount_percentage: 0)
    return trainer.profile.try(:price_cents) if option.name == '1 session'

    (trainer.profile.try(:price_cents) * option.number_of_sessions) *  discount_percentage
  end

  def per_session_cost(trainer, option, discount_percentage: discount_percentage)
    return trainer.profile.try(:price).format if option.name == '1 session'

    price = (sessions_cost(trainer, option, discount_percentage: discount_percentage) / option.number_of_sessions)
    Money.new(price).format
  end

  private

  def total_session_cost(option, trainer)
    return trainer.profile.try(:price).format if option.name == '1 session'

    total = sessions_cost(trainer, option, discount_percentage: session_discount[option.number_of_sessions.to_s])
    Money.new(total).format
  end
end
