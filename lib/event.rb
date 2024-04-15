require 'date'

class Event
    attr_reader :name, 
                :food_trucks,
                :overstocked_items
    
    def initialize(name)
        @name = name
        @food_trucks = []
        @overstocked_items = []
    end
    
    def add_food_truck(food_truck)
        @food_trucks << food_truck
        #add trucks to array
    end
    
    def food_truck_names
        @food_trucks.map do |food_truck| 
            food_truck.name 
        end
        #return new arr of truck names
    end
    
    def food_trucks_that_sell(item)
        @food_trucks.select  do |food_truck|
            food_truck.check_stock(item) > 0 
        end
        #find trucks that have item in stock, return array of trucks
    end

    def check_overstock
        @food_trucks.each do |food_truck|
            food_truck.inventory.each do |item, quantity|
                if quantity > 50
                    @overstocked_items << item
                end
            end
        end
        @overstocked_items
    end
    #iterate through trucks, check inventory for items over 50, add to array

    def items_at_event
        items = []
        @food_trucks.each do |food_truck|
            food_truck.inventory.each do |item, quantity|
                items << item
            end
            # move our items from food_truck inventory to items array
        end
        map_and_sort_items(items.uniq)
        # uniq removes duplicates then sort by name
    end

    def map_and_sort_items(arr)
        arr.map do |item|
            item.name
        end.sort
    end
    # helper method to map and sort items

    def total_inventory
        total_inventory = {}
        @food_trucks.each do |food_truck|
            food_truck.inventory.each do |item, quantity|
                total_inventory[item] = { # do we want it to be item name or item object?
                    quantity: total_quantity(item),
                    food_trucks: food_trucks_that_sell(item)
                }
            end
            # iterate through trucks, add items to total inventory hash
        end
        total_inventory
    end

    def total_quantity(item)
        @food_trucks.sum do |food_truck|
            food_truck.check_stock(item)
        end
    end
    # helper method to sum total quantity of items
end