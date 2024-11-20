//
//  Limitless.m
//  Limitless
//
//  Created by Francesco on 20/11/24.
//

#import "Limitless.h"

@implementation Limitless

+ (void)load {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5.0 * 60 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        abort();
    });
}

@end
