module Granite::ValidationHelpers
  macro validate_not_blank(field)
    validate {{field}}, "#{{{field}}} must not be blank", Proc(self, Bool).new { |model| !model.{{field.id}}.to_s.blank? }
  end

  macro validate_not_nil(field)
    validate {{field}}, "#{{{field}}} must not be nil", Proc(self, Bool).new { |model| !model.{{field.id}}.nil? }
  end

  macro validate_is_blank(field)
    validate {{field}}, "#{{{field}}} must be blank", Proc(self, Bool).new { |model| model.{{field.id}}.to_s.blank? }
  end

  macro validate_is_nil(field)
    validate {{field}}, "#{{{field}}} must be nil", Proc(self, Bool).new { |model| model.{{field.id}}.nil? }
  end

  macro validate_is_valid_choice(field, choices)
    validate {{field}}, "#{{{field}}} has an invalid choice. Valid choices are: #{{{choices.join(',')}}}", Proc(self, Bool).new { |model| {{choices}}.includes? model.{{field.id}} }
  end

  macro validate_greater_than(field, amount, orEqualTo = false)
    validate {{field}}, "#{{{field}}} must be greater than#{{{orEqualTo}} ? " or equal to" : ""} #{{{amount}}}", Proc(self, Bool).new { |model| (model.{{field.id}}.not_nil! {% if orEqualTo %} >= {% else %} > {% end %} {{amount.id}}) }
  end

  macro validate_less_than(field, amount, orEqualTo = false)
    validate {{field}}, "#{{{field}}} must be less than#{{{orEqualTo}} ? " or equal to" : ""} #{{{amount}}}", Proc(self, Bool).new { |model| (model.{{field.id}}.not_nil! {% if orEqualTo %} <= {% else %} < {% end %} {{amount.id}}) }
  end

  macro validate_min_length(field, length)
    validate {{field}}, "#{{{field}}} is too short. It must be at least #{{{length}}}", Proc(self, Bool).new { |model| (model.{{field.id}}.not_nil!.size >= {{length.id}}) }
  end

  macro validate_max_length(field, length)
    validate {{field}}, "#{{{field}}} is too long. It must be at most #{{{length}}}", Proc(self, Bool).new { |model| (model.{{field.id}}.not_nil!.size <= {{length.id}}) }
  end
end
