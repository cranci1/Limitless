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
                    alertControllerWithTitle:@"Limitless delay"
                    message:@"Enter delay time in seconds for when to crash the app"
                    preferredStyle:UIAlertControllerStyleAlert];
                
                [alert addTextFieldWithConfigurationHandler:^(UITextField *textField) {
                    textField.keyboardType = UIKeyboardTypeNumberPad;
                    textField.placeholder = @"300";
                }];
                
                UIAlertAction *confirmAction = [UIAlertAction
                    actionWithTitle:@"Confirm"
                    style:UIAlertActionStyleDefault
                    handler:^(UIAlertAction *action) {
                        NSString *input = alert.textFields.firstObject.text;
                        double seconds = input.length > 0 ? input.doubleValue : 300.0;
                        
                        [[NSUserDefaults standardUserDefaults] setDouble:seconds forKey:@"DelayTimeInSeconds"];
                        [[NSUserDefaults standardUserDefaults] synchronize];
                        
                        [self scheduleAbortWithDelay:seconds];
                    }];
                
                [alert addAction:confirmAction];
                
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

+ (void)scheduleAbortWithDelay:(double)seconds {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(seconds * NSEC_PER_SEC)),
        dispatch_get_main_queue(), ^{
            abort();
    });
}

@end
