require 'spec_helper'

RSpec.describe Dmv do
  before(:each) do
    @dmv = Dmv.new
    @facility_1 = Facility.new({name: 'DMV Tremont Branch', address: '2855 Tremont Place Suite 118 Denver CO 80205', phone: '(720) 865-4600'})
    @facility_2 = Facility.new({name: 'DMV Northeast Branch', address: '4685 Peoria Street Suite 101 Denver CO 80239', phone: '(720) 865-4600'})
    @facility_3 = Facility.new({name: 'DMV Northwest Branch', address: '3698 W. 44th Avenue Denver CO 80211', phone: '(720) 865-4600'})
  end

  describe '#initialize' do
    it 'can initialize' do
      expect(@dmv).to be_an_instance_of(Dmv)
      expect(@dmv.facilities).to eq([])
    end
  end

  describe '#add facilities' do
    it 'can add available facilities' do
      expect(@dmv.facilities).to eq([])
      @dmv.add_facility(@facility_1)
      expect(@dmv.facilities).to eq([@facility_1])
    end
  end

  describe '#facilities_offering_service' do
    it 'can return list of facilities offering a specified Service' do
      @facility_1.add_service('New Drivers License')
      @facility_1.add_service('Renew Drivers License')
      @facility_2.add_service('New Drivers License')
      @facility_2.add_service('Road Test')
      @facility_2.add_service('Written Test')
      @facility_3.add_service('New Drivers License')
      @facility_3.add_service('Road Test')

      @dmv.add_facility(@facility_1)
      @dmv.add_facility(@facility_2)
      @dmv.add_facility(@facility_3)

      expect(@dmv.facilities_offering_service('Road Test')).to eq([@facility_2, @facility_3])
    end
  end

  describe '#create_facilities' do
    before(:each) do
      @co_dmv_office_locations = DmvDataService.new.co_dmv_office_locations
      @ny_dmv_office_locations = DmvDataService.new.ny_dmv_office_locations
      @mo_dmv_office_locations = DmvDataService.new.mo_dmv_office_locations
    end
    
    it 'can format address data from various data sources into a string' do
      co_address = @dmv.format_address(@co_dmv_office_locations.first)
      ny_address = @dmv.format_address(@ny_dmv_office_locations.first)
      mo_address = @dmv.format_address(@mo_dmv_office_locations.first)
      
      expect(co_address).to be_a String
      expect(ny_address).to be_a String
      expect(mo_address).to be_a String
    end

    it 'can format name data from various data sources' do
      co_name = @dmv.format_name(@co_dmv_office_locations.first)
      ny_name = @dmv.format_name(@ny_dmv_office_locations.first)
      mo_name = @dmv.format_name(@mo_dmv_office_locations.first)
      
      expect(co_name).to be_a String
      expect(ny_name).to be_a String
      expect(mo_name).to be_a String
    end

    it 'can format phone data from various data sources' do
      co_phone = @dmv.format_phone(@co_dmv_office_locations.first)
      ny_phone = @dmv.format_phone(@ny_dmv_office_locations.first)
      mo_phone = @dmv.format_phone(@mo_dmv_office_locations.first)
      
      expect(co_phone).to be_a String
      expect(ny_phone).to be_a String
      expect(mo_phone).to be_a String
    end

    it 'can create facilities from CO DMV data' do
      co_facilities = @dmv.create_facilities(@co_dmv_office_locations)

      expect(co_facilities).to be_an_instance_of Array
      expect(co_facilities.first).to be_an_instance_of Facility
      expect(co_facilities.first.name).to be_a String
      expect(co_facilities.first.address).to be_a String
      expect(co_facilities.first.phone).to be_a String
      expect(co_facilities.first.collected_fees).to eq 0
      expect(co_facilities.first.services).to eq []
    end

    it 'can create facilities from NY DMV data' do
      ny_facilities = @dmv.create_facilities(@ny_dmv_office_locations)

      expect(ny_facilities).to be_an_instance_of Array
      expect(ny_facilities.first).to be_an_instance_of Facility
      expect(ny_facilities.first.name).to be_a String
      expect(ny_facilities.first.address).to be_a String
      expect(ny_facilities.first.phone).to be_a String
      expect(ny_facilities.first.collected_fees).to eq 0
      expect(ny_facilities.first.services).to eq []
    end

    it 'can create facilities from MO DMV data' do
      mo_facilities = @dmv.create_facilities(@mo_dmv_office_locations)

      expect(mo_facilities).to be_an_instance_of Array
      expect(mo_facilities.first).to be_an_instance_of Facility
      expect(mo_facilities.first.name).to be_a String
      expect(mo_facilities.first.address).to be_a String
      expect(mo_facilities.first.phone).to be_a String
      expect(mo_facilities.first.collected_fees).to eq 0
      expect(mo_facilities.first.services).to eq []
    end
  end
end
