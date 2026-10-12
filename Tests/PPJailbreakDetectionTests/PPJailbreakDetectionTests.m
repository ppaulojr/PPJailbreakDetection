@import XCTest;
@import PPJailbreakDetection;

@interface PPJailbreakDetectionTests : XCTestCase
@end

@implementation PPJailbreakDetectionTests

- (void)testSimulatorIsNotJailbroken
{
    XCTAssertFalse([PPJailbreakDetection isJailbroken]);
}

- (void)testProbabilityIsWithinRange
{
    float p = [PPJailbreakDetection jailbreakProbability];
    XCTAssertGreaterThanOrEqual(p, 0.0f);
    XCTAssertLessThanOrEqual(p, 1.0f);
}

- (void)testLegacyProbabilityMatchesNewName
{
    XCTAssertEqual([PPJailbreakDetection probabilityJailbroaken], [PPJailbreakDetection jailbreakProbability]);
}

@end
