require './lib/item'
require './lib/food_truck'

RSpec.describe FoodTruck do
    it 'exists' do
        food_truck = FoodTruck.new("Rocky Mountain Pies")
        expect(food_truck).to be_a(FoodTruck)
    end

    it 'has a name' do
        food_truck = FoodTruck.new("Rocky Mountain Pies")

        expect(food_truck.name).to eq("Rocky Mountain Pies")
    end

    it 'has an inventory' do
        food_truck = FoodTruck.new("Rocky Mountain Pies")

        expect(food_truck.inventory).to eq({})
    end

    it 'can check stock' do
        food_truck = FoodTruck.new("Rocky Mountain Pies")
        item1 = Item.new({name: 'Peach Pie (Slice)', price: "$3.75"})

        expect(food_truck.check_stock(item1)).to eq(0)
    end
    #unstocked item

    it 'can stock items' do
        food_truck = FoodTruck.new("Rocky Mountain Pies")
        item1 = Item.new({name: 'Peach Pie (Slice)', price: "$3.75"})

        food_truck.stock(item1, 30)

        expect(food_truck.inventory).to eq({item1 => 30})
    end

    it 'can check stock' do
        food_truck = FoodTruck.new("Rocky Mountain Pies")
        item1 = Item.new({name: 'Peach Pie (Slice)', price: "$3.75"})

        food_truck.stock(item1, 30)

        expect(food_truck.check_stock(item1)).to eq(30)
        expect(food_truck.inventory).to eq({item1 => 30})
    end
    # stocked item

    it 'can stock multiple items' do
        food_truck = FoodTruck.new("Rocky Mountain Pies")
        item1 = Item.new({name: 'Peach Pie (Slice)', price: "$3.75"})
        item2 = Item.new({name: 'Apple Pie (Slice)', price: "$2.50"})

        food_truck.stock(item1, 30)
        food_truck.stock(item2, 12)

        expect(food_truck.inventory).to eq({item1 => 30, item2 => 12})
    end

end