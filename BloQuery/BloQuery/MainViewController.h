//
//  MainViewController.h
//  BloQuery
//
//  Created by MELANIE MCGANNEY on 7/11/16.
//  Copyright © 2016 Bloc. All rights reserved.
//

#import <UIKit/UIKit.h>
@import FirebaseDatabase;

//@import GoogleSignIn;
@interface MainViewController : UIViewController 

@property (strong, nonatomic) FIRDatabaseReference *ref;


- (IBAction)didCreateAccount:(id)sender;

- (IBAction)didTapEmailLogin:(id)sender;

- (IBAction)didTapSignOut:(id)sender;

-(IBAction)setDisplayName:(id)sender;

 

@property (weak, nonatomic) IBOutlet UITextField *emailField;

@property (nonatomic, strong) IBOutlet UIButton *createAccount;

@property (nonatomic, strong) IBOutlet UIButton *submitAccount;

@property (nonatomic, strong) IBOutlet UIButton *logoutAccount;

@property (weak, nonatomic) IBOutlet UITextField *passwordField;

@property (weak, nonatomic)IBOutlet UIViewController *questionsVC;
@property IBOutlet UIButton *questionsButton;


@end





