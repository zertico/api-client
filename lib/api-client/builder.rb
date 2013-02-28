module ApiClient
  module Builder
    def build(object, params)
      case true
        when params.instance_of?(Array) then return params.map { |a| new(a.merge(:response => params)) }
        when params.key?(remote_object) then return new(params[remote_object].merge(:response => params))
        when params.key?(remote_object.pluralize) then return params[remote_object.pluralize].map { |a| new(a.merge(:response => params)) }
        else return new(params.merge(:response => params))
      end
    end
  end
end
