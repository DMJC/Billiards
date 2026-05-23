//
//  main.m
//  Billiards
//
//  Created by Gregory Casamento on 5/23/26.
//

#import <AppKit/AppKit.h>
#import "AppDelegate.h"

int main(int argc, const char **argv) {
    @autoreleasepool
    {
        NSApplication *app = [NSApplication sharedApplication];

        AppDelegate *controller = [[AppDelegate alloc] init];
        [app setDelegate: controller];

        [app run];
    }

    return 0;
}
