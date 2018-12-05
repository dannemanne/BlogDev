class TagDecorator < Draper::Decorator
  delegate_all
  decorates_association :posts, scope: :posted

end
