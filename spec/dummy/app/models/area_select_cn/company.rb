module AreaSelectCn
  class Company  < ActiveRecord::Base
    self.table_name = "area_select_cn_companies"

    validates :region_code, presence: true

    def region_code
      @region_code ||= self.class.test_region_code
    end

    class << self

      attr_writer :test_region_code
      def test_region_code
        @test_region_code ||= "331002" 
      end
    end

  end
end
