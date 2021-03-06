require 'spec_helper'

describe Smess::Auto, iso_id: "7.2.1" do
  describe '#get_output_name_for_msisdn' do
    subject { Smess::Auto.new(Smess::Sms.new).get_output_name_for_msisdn(@msisdn) }

    it 'returns USA aggregator from the registry based on the single digit countrycode' do
      @msisdn = "12345677889"
      should == Smess::OUTPUT_BY_COUNTRY_CODE["1"]
    end

    it 'returns Swedish aggregator from the registry based on the 2 digit countrycode' do
      @msisdn = "46123456778"
      should == Smess::OUTPUT_BY_COUNTRY_CODE["46"]
    end

    it 'returns UAE aggregator from the registry based on the 3 digit countrycode' do
      @msisdn = "97112345677"
      should == Smess::OUTPUT_BY_COUNTRY_CODE["971"]
    end

    it 'handles quirky american countrycodes, part 1: Samoa' do
      @msisdn = "16841234567"
      should == Smess::OUTPUT_BY_COUNTRY_CODE["1684"]
    end

    it 'handles quirky american countrycodes, part 2: Anguilla' do
      @msisdn = "12641234567"
      should == Smess::OUTPUT_BY_COUNTRY_CODE["1264"]
    end

    it 'returns the default aggregator based on the countrycode we dont specify' do
      @msisdn = "99912345677"
      should == Smess::OUTPUT_BY_COUNTRY_CODE["0"]
    end

  end
end