class FoodTruck
    attr_reader :name, :inventory

    def initialize(name)
        @name = name
        @inventory = {}
    end

    def check_stock(item)
        @inventory[item] || 0
        #return 0 if item does not exist in inventory
    end

    def stock(item, quantity)
        @inventory[item] = check_stock(item) + quantity
        #checks current stock, adds new stock updates total in inventory
    end

    def potential_revenue
        @inventory.sum do |item, quantity|
            item.price * quantity
        end
        #sums all items in inventory
    end
end