module ActiveRecordAddons
  extend ActiveSupport::Concern

  module ClassMethods

    def handles_value_of(attribute, options = {})
      raise "Missing/Invalid argument :with in method call to 'handles_value_of'" unless options[:with] < BaseValue
      value_class = options[:with]
      accessor = options[:accessor] || value_class.name.underscore

      validates attribute, inclusion: value_class.ids, allow_blank: options[:allow_blank], unless: options[:unless]

      class_eval <<-RUBY_EVAL
          def #{accessor}
            @#{accessor} ||= #{ value_class.name }.new(#{attribute})
          end

          def #{accessor}=(#{ value_class.name.underscore })
            self.#{attribute} = #{ value_class.name.underscore }.try(:id)
            @#{accessor} = #{ value_class.name.underscore }
          end
      RUBY_EVAL

    end

  end
end

if Object.const_defined?('ActiveRecord')
  ActiveRecord::Base.send(:include, ActiveRecordAddons)
end
