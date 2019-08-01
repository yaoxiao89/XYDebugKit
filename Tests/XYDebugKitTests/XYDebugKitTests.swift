import XCTest
@testable import XYDebugKit

final class XYDebugKitTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(XYDebugKit().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
