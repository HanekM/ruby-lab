module ItemContainer
  def self.included(base)
    base.extend ClassMethods
    base.include InstanceMethods
  end

  module ClassMethods
  end

  module InstanceMethods
    include Enumerable

    def each 
      return unless block_given?
      items.each do |item|
          yield item
      end  
    end
    
    def add_item(item)
      @items << item
    end

    def remove_item(item)
      @items.delete(item)
    end

    def delete_items
      @items.clear
    end

    def to_s
      @items.each do |item|
        puts item.to_s
      end
    end

    def total_items
      @items.size
    end

    def average_rating()
      unless @items.empty?
        total_rating = @items.sum do |item|
          item.respond_to?(:rating) ? item.send(:rating) : "Рейтинг відсутній"
        end
        total_rating / @items.length.to_f
      else
        return
      end
    end
    
    def to_h
      {
        items: @items.map(&:to_h), 
        total_items: total_items,
        average_rating: average_rating,
      }
    end

    def method_missing(method_name, *arguments, &block) 
      if method_name.to_s.start_with?('show_all_items_by_') 
        attribute = method_name.to_s[18..-1] 
        show_all_items_by(attribute) 
      else 
        super 
      end 
    end 
    
    def respond_to_missing?(method_name, include_private = false) 
      method_name.to_s.start_with?('show_all_items_by_') || super 
    end 
    
    private 
    
    def show_all_items_by(attribute) 
      if @items.first.respond_to?(attribute) 
        sorted_items = @items.sort_by { |item| item.send(attribute) } 
        sorted_items.each { |item| puts item } 
      else 
        puts "Атрибут '#{attribute}' не знайдено у класі Item." 
      end 
    end
  end 
end 