require 'spec_helper'

describe Tag do
  let(:tag) { FactoryBot.build(:tag) }
  describe 'validations' do
    it 'validates name presence' do
      expect(tag).to be_valid

      tag.name = ''
      expect(tag).to be_invalid
    end
    it 'validates name uniqueness' do
      expect(tag).to be_valid

      FactoryBot.create(:tag, name: tag.name)
      expect(tag).to be_invalid
    end
  end
end
