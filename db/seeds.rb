Tax.destroy_all
Product.destroy_all
ProductTax.destroy_all

TAXES = [
  {
    id: 1,
    name: 'basic',
    rate: 0.1
  },
  {
    id: 2,
    name: 'import duty',
    rate: 0.05
  }
]
PRODUCTS = [
  {
    id: 1,
    name: 'book'
  },
  {
    id: 2,
    name: 'music CD'
  },
  {
    id: 3,
    name: 'chocolate bar'
  },
  {
    id: 4,
    name: 'imported box of chocolates'
  },
  {
    id: 5,
    name: 'imported bottle of perfume'
  },
  {
    id: 6,
    name: 'bottle of perfume'
  },
  {
    id: 7,
    name: 'packet of headache pills'
  }
]
PRODUCT_TAXES = [
  {
    product_id: 2,
    tax_id: 1
  },
  {
    product_id: 4,
    tax_id: 2
  },
  {
    product_id: 5,
    tax_id: 1
  },
  {
    product_id: 5,
    tax_id: 2
  },
  {
    product_id: 6,
    tax_id: 1
  },
  {
    product_id: 7,
    tax_id: 2
  }
]

Tax.create!(TAXES)
Product.create!(PRODUCTS)
ProductTax.create!(PRODUCT_TAXES)

puts "Taxes created: #{Tax.count}"
puts "Products created: #{Product.count}"
puts "ProductTaxes created: #{ProductTax.count}"
