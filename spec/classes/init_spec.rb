require 'spec_helper'
describe 'vjava' do
  context 'with default values for all parameters' do
    it { should contain_class('vjava') }
  end
end
