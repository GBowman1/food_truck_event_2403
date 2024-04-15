class Event
    attr_reader :name, :food_trucks
    
    def initialize(name)
        @name = name
        @food_trucks = []
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
end