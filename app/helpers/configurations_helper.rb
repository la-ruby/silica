# frozen_string_literal: true

# :nodoc:
module ConfigurationsHelper
  def configuration_face_tag(name, value, form)
    select_tag name.to_s,
               options_for_select([ ["bootstrap-font"], ["brand-font"], ["brand-font-2"] ], value),
               include_blank: 'Font face:',
               form: form,
               data: {
                 controller: 'submits-form-immediately',
                 action: 'submits-form-immediately#submit_form'
               }
  end


  def configuration_weight_tag(name, value, form)
    select_tag name.to_s,
               options_for_select([ "fw-normal", "fw-light", "fw-bold" ], value),
               include_blank: 'Font weight:',
               form: form,
               data: {
                 controller: 'submits-form-immediately',
                 action: 'submits-form-immediately#submit_form'
               }
  end

  def configuration_color_tag(name, label, value, form)
    "#{label}: <input name=\"#{name}\" class=\"d-inline-block\" value=\"#{ j value }\" form=\"#{form}\" data-controller=\"submits-form-immediately\" data-action=\"submits-form-immediately#submit_form\" style=\"width: 100px\">".html_safe
  end

  def configuration_size_tag(name, value, form)
    select_tag name.to_s,
               options_for_select([ "fs-1", "fs-2", "fs-3", "fs-4", "fs-5", "fs-6" ], value),
               include_blank: 'Font size:',
               form: form,
               data: {
                 controller: 'submits-form-immediately',
                 action: 'submits-form-immediately#submit_form'
               }
  end
end
