class CreateAreaSelectCnCompanies < ActiveRecord::Migration
  def change
    create_table :area_select_cn_companies do |t|
      t.string :name
      t.string :loc_code

      t.timestamps
    end
  end
end
