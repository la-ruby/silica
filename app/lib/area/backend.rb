module Area
  class Backend
    def style(name)
      case name
      when :basic
        BackendBasicStyle
      end
    end

    def footer?
      true
    end

    def nav?
      true
    end
  end
end
 
