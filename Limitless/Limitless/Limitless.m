//
//  Limitless.m
//  Limitless
//
//  Created by Francesco on 20/11/24.
//

#import "Limitless.h"
#import <UIKit/UIKit.h>

@implementation Limitless

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        BOOL isFirstLaunch = ![[NSUserDefaults standardUserDefaults] boolForKey:@"HasLaunchedOnce"];
        if (isFirstLaunch) {
            [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"HasLaunchedOnce"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                UIAlertController *alert = [UIAlertController
                    alertControllerWithTitle:@"Limitless Delay"
                    message:@"Choose delay time before crash"
                    preferredStyle:UIAlertControllerStyleAlert];
                
                UIAlertAction *threeMinAction = [UIAlertAction
                    actionWithTitle:@"3 Minutes"
                    style:UIAlertActionStyleDefault
                    handler:^(UIAlertAction *action) {
                        [self saveAndScheduleDelay:3 * 60];
                    }];
                
                UIAlertAction *fiveMinAction = [UIAlertAction
                    actionWithTitle:@"5 Minutes"
                    style:UIAlertActionStyleDefault
                    handler:^(UIAlertAction *action) {
                        [self saveAndScheduleDelay:5 * 60];
                    }];
                
                UIAlertAction *tenMinAction = [UIAlertAction
                    actionWithTitle:@"10 Minutes"
                    style:UIAlertActionStyleDefault
                    handler:^(UIAlertAction *action) {
                        [self saveAndScheduleDelay:10 * 60];
                    }];
                
                [alert addAction:threeMinAction];
                [alert addAction:fiveMinAction];
                [alert addAction:tenMinAction];
                
                UIWindow *window = [[UIApplication sharedApplication] keyWindow];
                UIViewController *rootViewController = window.rootViewController;
                [rootViewController presentViewController:alert animated:YES completion:nil];
            });
        } else {
            double seconds = [[NSUserDefaults standardUserDefaults] doubleForKey:@"DelayTimeInSeconds"];
            if (seconds == 0) seconds = 300.0;
            [self scheduleAbortWithDelay:seconds];
        }
    });
}

+ (void)saveAndScheduleDelay:(double)seconds {
    [[NSUserDefaults standardUserDefaults] setDouble:seconds forKey:@"DelayTimeInSeconds"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [self scheduleAbortWithDelay:seconds];
}

+ (void)scheduleAbortWithDelay:(double)seconds {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(seconds * NSEC_PER_SEC)),
        dispatch_get_main_queue(), ^{
            abort();
    });
}

@end
