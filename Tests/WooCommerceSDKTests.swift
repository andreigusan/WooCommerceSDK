import XCTest
@testable import WooCommerceSDK

let requestTimeout = 30.0

class WooCommerceSDKTests: XCTestCase {
	
	override func setUp() {
		super.setUp()

		let processInfo = NSProcessInfo.processInfo()
		let client = Client.sharedClient

		client.siteURL = processInfo.environment["WOOCOMMERCE_SITE_URL"]
		client.consumerKey = processInfo.environment["WOOCOMMERCE_CONSUMER_KEY"]
		client.consumerSecret = processInfo.environment["WOOCOMMERCE_CONSUMER_SECRET"]
	}

	func testGetCustomer() {
		let expectation: XCTestExpectation = self.expectationWithDescription("testGetCustomer")
		Customer.get(2) { success, customer in
			if success == true {
				XCTAssertNotNil(customer, "Customer object should not be nil.")
				XCTAssertEqual(customer?.id, 2, "Returned customer id should be matched.")
			}
			expectation.fulfill()
		}
		self.waitForExpectationsWithTimeout(requestTimeout, handler: nil)
	}

    func testGetCustomerOrders() {
        let expectation: XCTestExpectation = self.expectationWithDescription("testGetCustomerOrders")
        Customer.getOrders(2) { (success, orders) -> Void in
            XCTAssertNotNil(orders)
            expectation.fulfill()
        }
        self.waitForExpectationsWithTimeout(requestTimeout, handler: nil)
    }
    
	func testGetOrder() {
		let expectation: XCTestExpectation = self.expectationWithDescription("testGetOrder")
		Order.get(12) { success, order in
			if success == true {
				XCTAssertNotNil(order, "Order object should not be nil.")
				XCTAssertEqual(order?.id, 12, "Returned order id should be matched.")
			}
			expectation.fulfill()
		}
		self.waitForExpectationsWithTimeout(requestTimeout, handler: nil)
	}

//    func testCreateEmptyOrder() {
//        let expectation: XCTestExpectation = self.expectationWithDescription("testCreateEmptyOrder")
//        let order = Order()
//
//        Order.create(order) { success, newOrder in
//            if success == true {
//                XCTAssertNotNil(newOrder, "Order object should not be nil.")
//                XCTAssert(newOrder!.status == "pending", "Order status should be Pending Payment.")
//            }
//            expectation.fulfill()
//        }
//
//        self.waitForExpectationsWithTimeout(requestTimeout, handler: nil)
//    }
//
//    func testCreateOrder() {
//        let expectation: XCTestExpectation = self.expectationWithDescription("testCreateOrder")
//
//        var order = Order()
//        var paymentDetails = PaymentDetails()
//        var billingAddress = Address()
//        var lineItem = LineItem()
//
//        paymentDetails.methodId = "paypal"
//        paymentDetails.methodTitle = "PayPal"
//        paymentDetails.paid = true
//
//        billingAddress.firstName = "John"
//        billingAddress.lastName = "Doe"
//        billingAddress.address1 = "969 Market"
//        billingAddress.city = "San Francisco"
//        billingAddress.state = "CA"
//        billingAddress.postcode = "94103"
//        billingAddress.country = "US"
//        billingAddress.email = "john.doe@example.com"
//        billingAddress.phone = "(555) 555-5555"
//
//        lineItem.productId = 8
//        lineItem.quantity = 1
//
//        order.paymentDetails = paymentDetails
//        order.billingAddress = billingAddress
//        order.customerId = 2
//        order.lineItems = [lineItem]
//
//        Order.create(order) { success, newOrder in
//            if success == true {
//                XCTAssertNotNil(newOrder, "Order object should not be nil.")
//            }
//            expectation.fulfill()
//        }
//        self.waitForExpectationsWithTimeout(requestTimeout, handler: nil)
//    }

	func testGetProduct() {
		let expectation: XCTestExpectation = self.expectationWithDescription("testGetProduct")
		Product.get(8) { success, product in
			if success == true {
				XCTAssertNotNil(product, "Product object should not be nil.")
				XCTAssertEqual(product?.id, 8, "Returned product id should be matched.")
			}
			expectation.fulfill()
		}
		self.waitForExpectationsWithTimeout(requestTimeout, handler: nil)
	}

    func testGetProductCategories() {
        let expectation: XCTestExpectation = self.expectationWithDescription("testGetProductCategories")
        ProductCategory.getAll(limit: 100, completion: { (success, categories) -> Void in
            XCTAssertNotNil(categories)
            expectation.fulfill()
        })
        self.waitForExpectationsWithTimeout(requestTimeout, handler: nil)
    }

    func testGetAllProductsByCategory() {
        let expectation: XCTestExpectation = self.expectationWithDescription("testGetAllProductByCategory")
        var category = ProductCategory()
        category.slug = "hoodies"
        Product.getAll(byCategory: category) { (success, products) -> Void in
            XCTAssertNotNil(products)
            expectation.fulfill()
        }
        self.waitForExpectationsWithTimeout(requestTimeout, handler: nil)
    }

    func testGetAllProducts() {
        let expectation: XCTestExpectation = self.expectationWithDescription("testGetAllProducts")
        var category = ProductCategory()
        category.slug = "hoodies"
        Product.getAll(limit: 1000) { (success, products) -> Void in
            XCTAssertNotNil(products)
            expectation.fulfill()
        }
        self.waitForExpectationsWithTimeout(requestTimeout, handler: nil)
    }

    func testGetStatuses() {
        let expectation: XCTestExpectation = self.expectationWithDescription("testGetStatuses")
        let client = Client.sharedClient
        client.getStatuses { success, value in
            XCTAssertNotNil(client.statuses)
            XCTAssertEqual(client.statuses?.getStatusName("cancelled"), "Cancelled")
            XCTAssertEqual(client.statuses?.getStatusName("completed"), "Completed")
            XCTAssertEqual(client.statuses?.getStatusName("failed"), "Failed")
            XCTAssertEqual(client.statuses?.getStatusName("on-hold"), "On Hold")
            XCTAssertEqual(client.statuses?.getStatusName("pending"), "Pending Payment")
            XCTAssertEqual(client.statuses?.getStatusName("processing"), "Processing")
            XCTAssertEqual(client.statuses?.getStatusName("refunded"), "Refunded")
            expectation.fulfill()
        }
        self.waitForExpectationsWithTimeout(requestTimeout, handler: nil)
    }
}
