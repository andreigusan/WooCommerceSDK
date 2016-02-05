import XCTest
@testable import WooCommerce

class WooCommerceTests: XCTestCase {
    
    override func setUp() {
        super.setUp()

        let processInfo = NSProcessInfo.processInfo()
        let client = Client.sharedClient

        client.siteURL = processInfo.environment["WOOCOMMERCE_SITE_URL"]
        client.consumerKey = processInfo.environment["WOOCOMMERCE_CONSUMER_KEY"]
        client.consumerSecret = processInfo.environment["WOOCOMMERCE_CONSUMER_SECRET"]
    }

    func testGetOrder() {
        let expectation: XCTestExpectation = self.expectationWithDescription("Order Test")
        Order.get(10) { (success: Bool, order: Order?) -> Void in
            XCTAssertEqual(order?.id, 10)
            expectation.fulfill()
        }
        self.waitForExpectationsWithTimeout(30, handler: nil)
    }
}
