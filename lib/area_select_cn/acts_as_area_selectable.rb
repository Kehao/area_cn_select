module AreaSelectCn
  module ActsAsAreaSelectable
    extend ActiveSupport::Concern

    module ClassMethods
      def acts_as_area_field(*items)
        items.each do |item|
          class_eval <<-EVAL
              alias_method :_#{item}, :#{item}
              def #{item}
                val = _#{item}
                @_#{item} = AreaSelectCn::Id.new(val) if !defined?(@_#{item}) || val.to_s != @_#{item}.to_s
              end
          EVAL
        end
      end
    end
  end
end
