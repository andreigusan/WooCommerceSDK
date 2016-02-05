import XCTest
@testable import WooCommerce

let requestTimeout = 30.0

class WooCommerceTests: XCTestCase {
    
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
            }
            expectation.fulfill()
        }
        self.waitForExpectationsWithTimeout(requestTimeout, handler: nil)
    }

    func testGetOrder() {
        let expectation: XCTestExpectation = self.expectationWithDescription("testGetOrder")
        Order.get(12) { success, order in
            XCTAssertEqual(order?.id, 12)
            expectation.fulfill()
        }
        self.waitForExpectationsWithTimeout(requestTimeout, handler: nil)
    }

    func testGetProduct() {
        let expectation: XCTestExpectation = self.expectationWithDescription("testGetProduct")
        Product.get(8) { success, product in
            if success == true {
                XCTAssertNotNil(product, "Product object should not be nil.")
            }
            expectation.fulfill()
        }
        self.waitForExpectationsWithTimeout(requestTimeout, handler: nil)
    }
}
