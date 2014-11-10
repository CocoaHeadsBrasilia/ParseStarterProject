//
//  CHLoginViewController.m
//  CocoaHeadsBrasilia
//
//  Created by IRAWILD ALMADA on 24/10/14.
//
//

#import "CHLoginViewController.h"
#import <Parse/Parse.h>

@interface CHLoginViewController ()

@end

@implementation CHLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)didUserNameEnd:(id)sender
{
    [self.userName resignFirstResponder];
    [self.password becomeFirstResponder];
}

- (IBAction)didPasswordEnd:(id)sender
{
    [self.password resignFirstResponder];
}

- (IBAction)entrarSelected:(id)sender
{
    [self.userName resignFirstResponder];
    [self.password resignFirstResponder];
    [self login];
}

-(void)login
{
    [self.activityView startAnimating];
    [PFUser logInWithUsernameInBackground:self.userName.text password:self.password.text block:^(PFUser *user, NSError *error)
    {
        if (!error)
        {
            [self.activityView stopAnimating];
            CGRect frame = [[UIScreen mainScreen] bounds];
            [UIView beginAnimations:nil context:NULL];
            [UIView setAnimationDuration:0.5f];
            [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
            [self.view setFrame:CGRectMake(0, -frame.size.height, frame.size.width, frame.size.height)];
            [UIView commitAnimations];
            //[self.window setRootViewController:mainViewController];
            
            [self.view performSelector:@selector(removeFromSuperview) withObject:nil afterDelay:1.0f];
        }
        else
        {
            [self.activityView stopAnimating];
            UIAlertView *errorAlert = [[UIAlertView alloc] initWithTitle:@"Falha"
                                                                 message:@"Não foi possível autenticar o usuário."
                                                                delegate:nil
                                                       cancelButtonTitle:@"OK"
                                                       otherButtonTitles:nil, nil];
            [errorAlert show];
    
        }
    }];
}

@end
