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
        Product.getAll(byCategory: category) { (success, categories) -> Void in
            XCTAssertNotNil(categories)
            expectation.fulfill()
        }
        self.waitForExpectationsWithTimeout(requestTimeout, handler: nil)
    }
}
