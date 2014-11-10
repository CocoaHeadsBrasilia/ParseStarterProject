//
//  Copyright 2014 Parse, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CHLoginViewController.h"
#import "CHPacienteViewController.h"

@interface CocoaHeadsAppDelegate : NSObject <UIApplicationDelegate>

@property (nonatomic, strong) IBOutlet UIWindow *window;

@property (nonatomic, strong) CHLoginViewController *loginViewController;
@property (nonatomic, strong) CHPacienteViewController *pacienteViewController;

@end
