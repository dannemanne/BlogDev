require 'spec_helper'

describe Linkback do
  let(:linkback) { FactoryBot.build(:linkback) }
  it 'validates source_uri presence' do
    expect(linkback).to be_valid

    linkback.source_uri = ''
    expect(linkback).to be_invalid
  end
  it 'validates target_uri presence' do
    expect(linkback).to be_valid

    linkback.target_uri = ''
    expect(linkback).to be_invalid
  end
  it 'validates source_uri and target_uri uniqueness' do
    expect(linkback).to be_valid

    FactoryBot.create(:linkback, source_uri: linkback.source_uri, target_uri: linkback.target_uri)
    expect(linkback).to be_invalid
  end
end
