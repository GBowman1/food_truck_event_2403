require './lib/item'
require './lib/food_truck'
require './lib/event'

RSpec.describe Event do
    before(:each) do
        @event = Event.new("South Pearl Street Farmers Market")

        @food_truck1 = FoodTruck.new("Rocky Mountain Pies")
        @food_truck2 = FoodTruck.new("Ba-Nom-a-Nom")
        @food_truck3 = FoodTruck.new("Palisade Peach Shack")

        @item1 = Item.new({name: 'Peach Pie (Slice)', price: "$3.75"})
        @item2 = Item.new({name: 'Apple Pie (Slice)', price: "$2.50"})
        @item3 = Item.new({name: 'Peach-Raspberry Nice Cream', price: "$5.30"})
        @item4 = Item.new({name: 'Banana Nice Cream', price: "$4.25"})
    end

    describe '#initialize' do
        it 'exists' do
            expect(@event).to be_a(Event)
        end

        it 'has a name' do
            expect(@event.name).to eq("South Pearl Street Farmers Market")
        end

        it 'has no food trucks' do
            expect(@event.food_trucks).to eq([])
        end
    end

    describe '#add_food_truck' do
        it 'adds food trucks to event' do
            @event.add_food_truck(@food_truck1)
            @event.add_food_truck(@food_truck2)
            @event.add_food_truck(@food_truck3)

            expect(@event.food_trucks).to eq([@food_truck1, @food_truck2, @food_truck3])
        end
    end

    describe '#food_truck_names' do
        it 'returns names of food trucks' do
            @event.add_food_truck(@food_truck1)
            @event.add_food_truck(@food_truck2)
            @event.add_food_truck(@food_truck3)

            expect(@event.food_truck_names).to eq(["Rocky Mountain Pies", "Ba-Nom-a-Nom", "Palisade Peach Shack"])
        end
    end

    describe '#food_trucks_that_sell' do
        it 'returns food trucks that sell specific item' do
            @event.add_food_truck(@food_truck1)
            @event.add_food_truck(@food_truck2)
            @event.add_food_truck(@food_truck3)

            @food_truck1.stock(@item1, 35)
            @food_truck1.stock(@item2, 7)
            @food_truck2.stock(@item4, 50)
            @food_truck2.stock(@item3, 25)
            @food_truck3.stock(@item1, 65)

            expect(@event.food_trucks_that_sell(@item1)).to eq([@food_truck1, @food_truck3])
            expect(@event.food_trucks_that_sell(@item4)).to eq([@food_truck2])
        end
    end

    describe '#items_at_event' do
        it 'returns all items at event in alphabetical list' do
            @event.add_food_truck(@food_truck1)
            @event.add_food_truck(@food_truck2)
            @event.add_food_truck(@food_truck3)

            @food_truck1.stock(@item1, 35)
            @food_truck1.stock(@item2, 7)
            @food_truck2.stock(@item4, 50)
            @food_truck2.stock(@item3, 25)
            @food_truck3.stock(@item1, 65)

            expect(@event.items_at_event).to eq(["Apple Pie (Slice)", "Banana Nice Cream", "Peach Pie (Slice)", "Peach-Raspberry Nice Cream"])
        end
    end

    describe '#total_inventory' do
        it 'returns all items at event in hash with quantity and what truck sells it' do
            @event.add_food_truck(@food_truck1)
            @event.add_food_truck(@food_truck2)
            @event.add_food_truck(@food_truck3)

            @food_truck1.stock(@item1, 35)
            @food_truck1.stock(@item2, 7)

            @food_truck2.stock(@item4, 50)
            @food_truck2.stock(@item3, 25)

            @food_truck3.stock(@item1, 65)

            expect(@event.total_inventory).to eq({
                @item1 => {
                    quantity: 100,
                    food_trucks: [@food_truck1, @food_truck3]
                },
                @item2 => {
                    quantity: 7,
                    food_trucks: [@food_truck1]
                },
                @item3 => {
                    quantity: 25,
                    food_trucks: [@food_truck2]
                },
                @item4 => {
                    quantity: 50,
                    food_trucks: [@food_truck2]
                }
            })
            # Yup now I feel like i'm making JavaScript objects
        end
    end

    describe '#overstocked_items' do
        it 'returns items that are sold by more than 1 truck and have more than 50 in stock' do
            @event.add_food_truck(@food_truck1)
            @event.add_food_truck(@food_truck2)
            @event.add_food_truck(@food_truck3)

            @food_truck1.stock(@item1, 35)
            @food_truck1.stock(@item2, 7)

            @food_truck2.stock(@item4, 50)
            @food_truck2.stock(@item3, 25)

            @food_truck3.stock(@item1, 65)

            @event.check_overstock

            expect(@event.overstocked_items).to eq([@item1])
        end
    end

    # describe '#start_date' do
    #     it 'returns date of event in dd/mm/yyyy format' do
    #         expect(@event.start_date).to eq("08-10-1998")
    #         allow(@event).to receive(:start_date).and_return("08-10-1998")
    #     end
    # end

    # come back to the stub thing later

    describe '#sell' do
        it 'returns true if event has enough of item and decreases stock of food truck' do
            @event.add_food_truck(@food_truck1)
            @event.add_food_truck(@food_truck2)
            @event.add_food_truck(@food_truck3)

            @food_truck1.stock(@item1, 35)
            @food_truck1.stock(@item2, 7)

            @food_truck2.stock(@item4, 50)
            @food_truck2.stock(@item3, 25)

            @food_truck3.stock(@item1, 65)

            expect(@event.sell(@item1, 40)).to eq(true)
            # there is enough stock should return true and decrease stock to 60
            expect(@food_truck1.check_stock(@item1)).to eq(0)
            expect(@food_truck3.check_stock(@item1)).to eq(60)
            # priorotizes truck1 sells out then goes to truck 3
        end

        it 'returns false if event does not have enough of item' do
            @event.add_food_truck(@food_truck1)
            @event.add_food_truck(@food_truck2)
            @event.add_food_truck(@food_truck3)

            @food_truck1.stock(@item1, 35)
            @food_truck1.stock(@item2, 7)

            @food_truck2.stock(@item4, 50)
            @food_truck2.stock(@item3, 25)

            @food_truck3.stock(@item1, 65)

            expect(@event.sell(@item1, 200)).to eq(false)
            # there is not enough stock should return false
            expect(@food_truck1.check_stock(@item1)).to eq(35)
            expect(@food_truck3.check_stock(@item1)).to eq(65)
        end
    end
end