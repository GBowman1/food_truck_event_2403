require './lib/item'

RSpec.describe Item do
    it 'exists' do
        item = Item.new({name: 'Peach Pie (Slice)', price: "$3.75"})
        expect(item).to be_a(Item)
    end

    it 'has a name' do
        item = Item.new({name: 'Peach Pie (Slice)', price: "$3.75"})

        expect(item.name).to eq('Peach Pie (Slice)')
    end

    it 'has a price' do
        item = Item.new({name: 'Peach Pie (Slice)', price: "$3.75"})

        expect(item.price).to eq(3.75)
    end
end