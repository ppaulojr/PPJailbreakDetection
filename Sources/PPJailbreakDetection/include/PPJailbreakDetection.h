//
//  PPJailbreakDetection.h
//  PPJailbreakDetection
//
//  Created by Pedro Paulo Oliveira Junior on 3/31/17.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/// Heuristic jailbreak detection for iOS.
///
/// No client-side check is tamper proof; treat the result as a signal, not a guarantee.
NS_SWIFT_NAME(JailbreakDetection)
@interface PPJailbreakDetection : NSObject

/// `YES` if any strong jailbreak indicator was found. Always `NO` on the simulator.
+ (BOOL)isJailbroken NS_SWIFT_NAME(isJailbroken());

/// A score in `0.0 ... 1.0` combining all indicators. Always `0.0` on the simulator.
+ (float)jailbreakProbability NS_SWIFT_NAME(jailbreakProbability());

/// Legacy (misspelled) name kept for source compatibility; use `+jailbreakProbability`.
+ (float)probabilityJailbroaken NS_SWIFT_UNAVAILABLE("Use jailbreakProbability()");

- (instancetype)init NS_UNAVAILABLE;

@end

NS_ASSUME_NONNULL_END
