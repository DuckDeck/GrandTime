import XCTest
@testable import GrandTime

final class GrandTimeTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(GrandTime().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
