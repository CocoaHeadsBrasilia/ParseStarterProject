//
//  CHLoginViewController.h
//  CocoaHeadsBrasilia
//
//  Created by IRAWILD ALMADA on 24/10/14.
//
//

#import <UIKit/UIKit.h>

@interface CHLoginViewController : UIViewController

@property (strong, nonatomic) IBOutlet UITextField *userName;
@property (strong, nonatomic) IBOutlet UITextField *password;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *activityView;


- (IBAction)didUserNameEnd:(id)sender;
- (IBAction)didPasswordEnd:(id)sender;
- (IBAction)entrarSelected:(id)sender;

@end
