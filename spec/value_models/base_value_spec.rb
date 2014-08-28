require 'spec_helper'

describe BaseValue do
  describe 'add_value' do
    it 'adds a new possible value for the Value Model' do
      expect( AddValueModel.ids ).to include AddValueModel::ADDED_VALUE
    end
  end

  describe 'ids' do
    it 'returns all the keys of the values hash' do
      expect( AddValueModel.ids ).to eq AddValueModel.values.keys
    end
  end

  describe 'labels' do
    it 'returns all the values for the label keys in the possible values' do
      expect( AddValueModel.labels ).to eq AddValueModel.values.values.map { |v| v[:label] }
    end
  end

  describe 'eql? and ==' do
    it 'returns true if the compared instances have the same id' do
      expect( AddValueModel.new(AddValueModel::ADDED_VALUE).eql?(AddValueModel.new(AddValueModel::ADDED_VALUE)) ).to eq true

      expect( AddValueModel.new(AddValueModel::ADDED_VALUE).eql?(AddValueModel.new(AddValueModel::SECOND_ADDED_VALUE)) ).to eq false

      expect( AddValueModel.new(AddValueModel::ADDED_VALUE) == AddValueModel.new(AddValueModel::ADDED_VALUE) ).to eq true

      expect( AddValueModel.new(AddValueModel::ADDED_VALUE) == AddValueModel.new(AddValueModel::SECOND_ADDED_VALUE) ).to eq false
    end
  end
end
