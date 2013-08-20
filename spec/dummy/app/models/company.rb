class Company < ActiveRecord::Base
  attr_accessor :region_code
  attr_accessible :region_code, :loc_code

  acts_as_area_field :region_code
  validates :region_code, presence: true
  validates :loc_code, presence: true
end
