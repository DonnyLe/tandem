import Testing
@testable import GoalKit

@Test func versionIsSet() {
    #expect(!GoalKit.version.isEmpty)
}
