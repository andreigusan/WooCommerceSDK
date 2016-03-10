# WooCommerceSDK
[![Build Status](https://travis-ci.org/thii/WooCommerceSDK.svg?branch=master)](https://travis-ci.org/thii/WooCommerceSDK)
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)

A wrapper around [WooCommerce REST API](http://woothemes.github.io/woocommerce-rest-api-docs/) for iOS, OS X, tvOS and watchOS, written purely in Swift.

## Requirements
- iOS 8.0+ / Mac OS X 10.9+ / tvOS 9.0+ / watchOS 2.0+
- Xcode 7.2+
- WooCommerce 2.4+

## Usage
Initialize the client once anywhere in your app (preferred to be in your `AppDelegate`).

```swift
let client = Client.sharedClient

client.siteURL = "https://example.com"
client.consumerKey = "YOUR_API_CONSUMER_KEY"
client.consumerSecret = "YOUR_API_CONSUMER_SECRET"
```

### Get an Order
```swift
let orderId = 12
Order.get(orderId) { success, order in
    print(order)
}
```

### Get a Customer
```swift
let customerId = 2
Customer.get(customerId) { success, customer in
    print(customer)
}
```

### Get Customer Orders
```swift
let customerId = 2
Customer.getOrders(customerId) { success, orders in
    print(orders)
}
```

### Get a Product
```swift
let productId = 8
Product.get(orderId) { success, product in
    print(product)
}
```

### Get List of Product Categories
```swift
ProductCategory.getAll(limit: 100, completion: { success, categories in
    print(categories)
})
```

### Get All Products by Category
```swift
var category = ProductCategory()
category.slug = "hoodies"
Product.getAll(byCategory: category) { success, products
    print(products)
}
```

## Installation
### [Carthage](https://github.com/Carthage/Carthage)
Add this to your `Cartfile`:

    github "thii/WooCommerceSDK" "master"

then

    $ carthage update

## License
MIT
