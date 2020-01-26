# coding: utf-8
module SessionHelper
  def select_options_html(trainer)
    content_tag(:select, { name: :option, id: :option, class: 'form-control', prompt: 'Select an option' }) do    
      Option.all.each do |option|
        concat(content_tag(:option, option.name, { value: option.id, data: { price: sessions_cost(trainer, option.number_of_sessions, discount_percentage: session_discount[option.number_of_sessions.to_s]), session_cost: per_session_cost(trainer, option.number_of_sessions, discount_percentage: session_discount[option.number_of_sessions.to_s])}}))
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

  def sessions_cost(trainer, number_of_sessions, discount_percentage: 0)
    (trainer.profile.try(:price) * number_of_sessions) *  discount_percentage
  end

  def per_session_cost(trainer, number_of_sessions, discount_percentage: discount_percentage)
    price = (sessions_cost(trainer, number_of_sessions, discount_percentage: discount_percentage) / number_of_sessions)
    number_to_currency(price, unit: '£', precision: 2) 
  end
end
