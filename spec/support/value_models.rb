class AddValueModel < BaseValue
  ADDED_VALUE = 51
  SECOND_ADDED_VALUE = 60

  add_value ADDED_VALUE, :added_label
  add_value SECOND_ADDED_VALUE, :second_added_label
end

class ModelStatus < BaseValue
  NEW = 0
  EXISTING = 1
  DESTROYED = 2

  add_value NEW,        :new
  add_value EXISTING,   :existing
  add_value DESTROYED,  :destroyed

end
