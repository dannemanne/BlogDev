require 'spec_helper'

describe CheatSheet do
  describe 'validations' do
    let(:cheat_sheet) { FactoryBot.build(:cheat_sheet) }
    it 'validates title presence' do
      expect( cheat_sheet ).to be_valid

      cheat_sheet.title = ''
      expect( cheat_sheet ).to be_invalid
    end
    it 'validates title uniqueness' do
      expect( cheat_sheet ).to be_valid

      FactoryBot.create(:cheat_sheet, title: cheat_sheet.title)
      expect( cheat_sheet ).to be_invalid
    end
    it 'validates body presence' do
      expect( cheat_sheet ).to be_valid

      cheat_sheet.body = ''
      expect( cheat_sheet ).to be_invalid
    end
  end

  describe '#display_body' do
    let(:cheat_sheet) { FactoryBot.create(:cheat_sheet) }
    it 'always returns a html safe content' do
      expect( cheat_sheet.display_body ).to be_html_safe
    end
  end
end
