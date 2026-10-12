//
//  PPJailbreakDetection.m
//  PPJailbreakDetection
//
//  Created by Pedro Paulo Oliveira Junior on 3/31/17.
//

#import "PPJailbreakDetection.h"

#import <TargetConditionals.h>
#import <mach-o/dyld.h>
#import <stdlib.h>
#import <string.h>
#import <sys/stat.h>
#import <unistd.h>

// Indicator weights; any single "strong" indicator is enough to report a jailbreak.
static const float kStrongWeight = 1.0f;
static const float kWeakWeight = 0.5f;

#if !TARGET_OS_SIMULATOR

static BOOL PPPathExists(const char *path)
{
    struct stat st;
    return lstat(path, &st) == 0;
}

static float PPFileSystemScore(void)
{
    static const char *const paths[] = {
        "/Applications/Cydia.app",
        "/Applications/Sileo.app",
        "/Applications/Zebra.app",
        "/Applications/Installer.app",
        "/Library/MobileSubstrate/MobileSubstrate.dylib",
        "/Library/MobileSubstrate/DynamicLibraries",
        "/usr/lib/libsubstrate.dylib",
        "/usr/lib/TweakInject",
        "/var/jb",
        "/var/lib/cydia",
        "/var/lib/dpkg/info",
        "/etc/apt",
        "/private/var/lib/apt",
        "/usr/sbin/sshd",
        "/usr/bin/sshd",
        "/bin/bash",
        "/bin/sh.jb",
    };
    for (size_t i = 0; i < sizeof(paths) / sizeof(paths[0]); ++i) {
        if (PPPathExists(paths[i])) {
            return kStrongWeight;
        }
    }
    return 0.0f;
}

/// A sandboxed process cannot write outside its container.
static float PPSandboxWriteScore(void)
{
    NSString *path = [NSString stringWithFormat:@"/private/%@", [[NSUUID UUID] UUIDString]];
    NSError *error = nil;
    BOOL wrote = [@"." writeToFile:path atomically:NO encoding:NSUTF8StringEncoding error:&error];
    if (wrote) {
        [[NSFileManager defaultManager] removeItemAtPath:path error:nil];
        return kStrongWeight;
    }
    return 0.0f;
}

/// Tweak loaders show up in the list of images mapped into the process.
static float PPInjectedLibraryScore(void)
{
    static const char *const needles[] = {
        "MobileSubstrate", "libsubstrate", "SubstrateLoader", "SubstrateInserter",
        "TweakInject", "libhooker", "ElleKit", "libellekit", "FridaGadget", "frida",
    };
    uint32_t count = _dyld_image_count();
    for (uint32_t i = 0; i < count; ++i) {
        const char *name = _dyld_get_image_name(i);
        if (!name) {
            continue;
        }
        for (size_t j = 0; j < sizeof(needles) / sizeof(needles[0]); ++j) {
            if (strstr(name, needles[j])) {
                return kStrongWeight;
            }
        }
    }
    return 0.0f;
}

static float PPEnvironmentScore(void)
{
    const char *insert = getenv("DYLD_INSERT_LIBRARIES");
    return (insert && *insert) ? kWeakWeight : 0.0f;
}

#endif // !TARGET_OS_SIMULATOR

@implementation PPJailbreakDetection

+ (float)jailbreakProbability
{
#if TARGET_OS_SIMULATOR
    return 0.0f;
#else
    float score = PPFileSystemScore() + PPSandboxWriteScore() + PPInjectedLibraryScore() + PPEnvironmentScore();
    return MIN(score, 1.0f);
#endif
}

+ (BOOL)isJailbroken
{
    return [self jailbreakProbability] >= kStrongWeight;
}

+ (float)probabilityJailbroaken
{
    return [self jailbreakProbability];
}

@end
