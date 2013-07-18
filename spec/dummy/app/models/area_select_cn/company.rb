module AreaSelectCn
  class Company  < ActiveRecord::Base
    self.table_name = "area_select_cn_companies"
    def region_code
      "331002"
    end
  end
end
