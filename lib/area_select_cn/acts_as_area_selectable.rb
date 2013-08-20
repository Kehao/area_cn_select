module AreaSelectCn
  module ActsAsAreaSelectable
    extend ActiveSupport::Concern

    module ClassMethods
      # For validates :region_code, presence: true
      # return nil or ""  if val.index[nil,""]
      def acts_as_area_field(*items)
        items.each do |item|
          class_eval <<-EVAL
              alias_method :_#{item}, :#{item}
              def #{item}
                val = _#{item}
                return val if val.blank?

                unless @_#{item} && val.eql?(@_#{item}.value)
                  @_#{item} = AreaSelectCn::Id.new(val) 
                end
                @_#{item}
              end
          EVAL
        end
      end
    end
  end
end
