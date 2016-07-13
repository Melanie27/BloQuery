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

- (IBAction)didCreateAccount:(id)sender;

- (IBAction)didTapEmailLogin:(id)sender;

- (IBAction)didTapSignOut:(id)sender;

@property (weak, nonatomic) IBOutlet UITextField *emailField;

@property (nonatomic, strong) IBOutlet UIButton *createAccount;

@property (nonatomic, strong) IBOutlet UIButton *submitAccount;

@property (nonatomic, strong) IBOutlet UIButton *logoutAccount;

@property (weak, nonatomic) IBOutlet UITextField *passwordField;




@end





