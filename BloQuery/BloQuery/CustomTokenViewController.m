//
//  CustomTokenViewController.m
//  BloQuery
//
//  Created by MELANIE MCGANNEY on 7/11/16.
//  Copyright © 2016 Bloc. All rights reserved.
//

#import "CustomTokenViewController.h"
#import "UIViewController+Alerts.h"

// [START auth_view_import]
@import FirebaseAuth;
// [END auth_view_import]

@interface CustomTokenViewController ()
@property(weak, nonatomic) IBOutlet UITextView *tokenField;
@end
@implementation CustomTokenViewController

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

- (IBAction)didTapCustomTokenLogin:(id)sender {
    NSString *customToken = _tokenField.text;
    [self showSpinner:^{
        // [START signinwithcustomtoken]
        [[FIRAuth auth] signInWithCustomToken:customToken
                                   completion:^(FIRUser *_Nullable user,
                                                NSError *_Nullable error) {
                                       // [START_EXCLUDE]
                                       [self hideSpinner:^{
                                           if (error) {
                                               [self showMessagePrompt:error.localizedDescription];
                                               return;
                                           }
                                           [self.navigationController popViewControllerAnimated:YES];
                                       }];
                                       // [END_EXCLUDE]
                                   }];
        // [END signinwithcustomtoken]
    }];
}

@end
