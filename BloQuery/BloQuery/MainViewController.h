//
//  MainViewController.h
//  BloQuery
//
//  Created by MELANIE MCGANNEY on 7/11/16.
//  Copyright © 2016 Bloc. All rights reserved.
//

#import <UIKit/UIKit.h>
//@import GoogleSignIn;
@interface MainViewController : UIViewController
- (IBAction)didGetProvidersForEmail:(id)sender;
- (IBAction)didCreateAccount:(id)sender;
- (IBAction)didRequestPasswordReset:(id)sender;
@property (nonatomic, strong) IBOutlet UIButton *createAccount;

@end





