module AreaSelectCn
  class Company  < ActiveRecord::Base
    attr_accessible :region_code
    attr_accessor :region_code
    self.table_name = "area_select_cn_companies"

    validates :region_code, presence: true
  end
end
