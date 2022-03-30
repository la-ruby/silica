module Area
  class Backend
    def style(name)
      case name
      when :basic
        BackendBasicStyle
      end
    end
  end
end
 
