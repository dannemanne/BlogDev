class BaseValue
  class_attribute :values
  attr_reader :id

  def self.ids
    values.keys
  end

  def self.labels
    values.values.map { |v| v[:label] }
  end

  def self.all
    ids.map { |id| new(id) }
  end

  def self.first
    new ids.first
  end

  def initialize(id)
    @id = id
  end

  def valid?
    self.class.ids.include? id
  end

  def label
    value_hash[:label]
  end

  def display_name
    I18n.t "values.#{ self.class.name.underscore }.#{label}"
  end

  def as_json(*args)
    value_hash.merge(id: id, name: display_name)
  end

  # Methods +hash+ and +eql?+ makes it possible to use
  # Value Models as a hash key, allowing other objects to
  # be grouped by the instances
  def hash
    id.hash
  end

  def eql?(other)
    id == other.id
  end

  def ==(other)
    eql?(other)
  end

  def method_missing(m, *args, &block)
    if (l = m[/^is_([a-z_]+)\?$/, 1]) && self.class.labels.include?(l.to_sym)
      # Returns true if the label matches the method name.
      # Example:
      #   is_work_in_progress?  => Will return +true+ if the label is :work_in_progress
      l.to_sym == label
    else
      super
    end
  end

protected
  def value_hash
    values[id] || {}
  end

  def self.add_value(id, label, attr = {})
    self.values ||= {}
    values[id] = attr.merge(label: label)
  end

end
