//
//  EmailViewController.m
//  BloQuery
//
//  Created by MELANIE MCGANNEY on 7/11/16.
//  Copyright © 2016 Bloc. All rights reserved.
//


#import "EmailViewController.h"
#import "UIViewController+Alerts.h"

@import FirebaseAuth;

@interface EmailViewController ()
@property(weak, nonatomic) IBOutlet UITextField *emailField;
@property(weak, nonatomic) IBOutlet UITextField *passwordField;
@end

@implementation EmailViewController

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

- (IBAction)didTapEmailLogin:(id)sender {
    [self showSpinner:^{
         [[FIRAuth auth] signInWithEmail:_emailField.text
                               password:_passwordField.text
                             completion:^(FIRUser *user, NSError *error) {
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
        // [END headless_email_auth]
    }];
}

/** @fn requestPasswordReset
 @brief Requests a "password reset" email be sent.
 */
- (IBAction)didRequestPasswordReset:(id)sender {
    [self
     showTextInputPromptWithMessage:@"Email:"
     completionBlock:^(BOOL userPressedOK, NSString *_Nullable userInput) {
         if (!userPressedOK || !userInput.length) {
             return;
         }
         
         [self showSpinner:^{
             // [START password_reset]
             [[FIRAuth auth]
              sendPasswordResetWithEmail:userInput
              completion:^(NSError *_Nullable error) {
                  // [START_EXCLUDE]
                  [self hideSpinner:^{
                      if (error) {
                          [self
                           showMessagePrompt:error
                           .localizedDescription];
                          return;
                      }
                      
                      [self showMessagePrompt:@"Sent"];
                  }];
                  // [END_EXCLUDE]
              }];
             // [END password_reset]
         }];
     }];
}

/** @fn getProvidersForEmail
 @brief Prompts the user for an email address, calls @c FIRAuth.getProvidersForEmail:callback:
 and displays the result.
 */
- (IBAction)didGetProvidersForEmail:(id)sender {
    [self
     showTextInputPromptWithMessage:@"Email:"
     completionBlock:^(BOOL userPressedOK, NSString *_Nullable userInput) {
         if (!userPressedOK || !userInput.length) {
             return;
         }
         
         [self showSpinner:^{
             // [START get_providers]
             [[FIRAuth auth]
              fetchProvidersForEmail:userInput
              completion:^(NSArray<NSString *> *_Nullable providers,
                           NSError *_Nullable error) {
                  // [START_EXCLUDE]
                  [self hideSpinner:^{
                      if (error) {
                          [self showMessagePrompt:error.localizedDescription];
                          return;
                      }
                      
                      [self showMessagePrompt:
                       [providers componentsJoinedByString:@", "]];
                  }];
                  // [END_EXCLUDE]
              }];
             // [END get_providers]
         }];
     }];
}

- (IBAction)didCreateAccount:(id)sender {
    [self
     showTextInputPromptWithMessage:@"Email:"
     completionBlock:^(BOOL userPressedOK, NSString *_Nullable email) {
         if (!userPressedOK || !email.length) {
             return;
         }
         
         [self
          showTextInputPromptWithMessage:@"Password:"
          completionBlock:^(BOOL userPressedOK,
                            NSString *_Nullable password) {
              if (!userPressedOK || !password.length) {
                  return;
              }
              
              [self showSpinner:^{
                  // [START create_user]
                  [[FIRAuth auth]
                   createUserWithEmail:email
                   password:password
                   completion:^(FIRUser *_Nullable user,
                                NSError *_Nullable error) {
                       // [START_EXCLUDE]
                       [self hideSpinner:^{
                           if (error) {
                               [self
                                showMessagePrompt:
                                error
                                .localizedDescription];
                               return;
                           }
                           NSLog(@"%@ created", user.email);
                           [self.navigationController popViewControllerAnimated:YES];
                       }];
                       // [END_EXCLUDE]
                   }];
                  // [END create_user]
              }];
          }];
     }];
}

@end