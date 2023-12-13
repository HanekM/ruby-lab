module Parser_program
  class Item

    include Comparable

    def initialize(attributes = {})
      attributes.each do |k, v|
          self.instance_variable_set "@#{k}", v
          self.class.send(:attr_accessor, k)
      end
    end
  
    def info
      yield self if block_given?
    end
  
    def to_s
      self.instance_variables.inject("") do |result_str, attr|
        value = self.instance_variable_get "#{attr}"
        attr_key = attr[1..-1].capitalize
        result_str + "#{attr_key}: #{value}; "
      end
    end
    
    def to_h
      self.instance_variables.inject({}) do |result_hash, attr|
          value = self.instance_variable_get "#{attr}"
          attr_key = attr[1..-1].to_sym
          result_hash[attr_key] = value
          result_hash
      end
    end

    def <=>(other_item)
      if self.respond_to?(:rating) && other_item.respond_to?(:rating)
        rating <=> other_item.rating
      else
        raise ArgumentError, "Attribute 'rating' does not exist in both objects."
      end
    end

  end
end
