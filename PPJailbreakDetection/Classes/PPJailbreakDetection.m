//
//  PPJailbreakDetection.m
//  Pods
//
//  Created by Pedro Paulo Oliveira Junior on 3/31/17.
//
//

#include <stdlib.h>

static char * forbidden [] = {"/Applications/Cydia.app","/bin/bash","/etc/apt","/Library/MobileSubstrate/MobileSubstrate.dylib","/usr/sbin/sshd","/usr/bin/ssh"};
static int forbiddenCount = 6;

bool jailbrokenFileSystem ()
{
    for (int i=0; i<forbiddenCount; ++i)
    {
        FILE *file = fopen(forbidden[i], "r");
        if (file) {
            fclose(file);
            return true;
        }
    }
    return false;
}

#import "PPJailbreakDetection.h"

@implementation PPJailbreakDetection


+ (BOOL)isJailbroken
{
#if !(TARGET_IOS_SIMULATOR)
    if (jailbrokenFileSystem()) {
        return YES;
    }
    return NO;
#else
    return NO;
#endif
}

+ (float)probabilityJailbroaken
{
#if !(TARGET_IOS_SIMULATOR)
    float points = 0.0f;
    return points;
#else
    return 0.0f;
#endif
}

@end
