import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(FullFeedback_iosTests.allTests),
    ]
}
#endif
