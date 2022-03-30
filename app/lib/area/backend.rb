module Area
  class Backend < Area::Base
    def style(name)
      case name
      when :basic
        BackendBasicStyle
      end
    end

    def footer?
      true
    end
  end
end
 
