//
//  UserProfileViewController.m
//  BloQuery
//
//  Created by MELANIE MCGANNEY on 8/22/16.
//  Copyright © 2016 Bloc. All rights reserved.
//

#import "UserProfileViewController.h"
#import "ImageLibraryViewController.h"
#import "BLCDataSource.h"

@import Firebase;
@import FirebaseDatabase;

@interface UserProfileViewController () <ImageLibraryViewControllerDelegate, UITextViewDelegate>
@property (strong, nonatomic) FIRDatabaseReference *ref;
@end

@implementation UserProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [[BLCDataSource sharedInstance] retrieveDescription];
    
    self.navigationItem.title = @"Your Profile";
    self.userDescription.returnKeyType = UIReturnKeyDone;
    self.userDescription.delegate = self;
    
    self.userName.returnKeyType = UIReturnKeyDone;
    
    FIRUser *userAuth = [FIRAuth auth].currentUser;
    if(userAuth) {
        NSLog(@"current user %@", userAuth);
    }
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.

}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    
    if([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        //save text to Firebase
        
        [self sendDescToFireBase];
        return NO;
    }
    
    return YES;
}

-(void)sendDescToFireBase {
    //FIRUser *userAuth = [FIRAuth auth].currentUser;
    self.ref = [[FIRDatabase database] reference];
    //NSString *userDescription = self.userDescription.text;
    self.userDescription.text = [BLCDataSource sharedInstance].userDesc;
    NSLog(@"userDesciption2 %@", self.userDescription);
    
    //NSDictionary *descriptionUpdates = @{[NSString stringWithFormat:@"/userData/%@/description/", userAuth.uid]:userDescription};
    
    //[_ref updateChildValues:descriptionUpdates];
    //NSLog(@"userDescription %@", userDescription);
   
    //update textview
   
    
}




//open view to allow user to select photo from image library
- (IBAction)didTapPhotoUpload:(id)sender {
    //NSLog(@"profile Photo %@", self.profilePhoto);
    ImageLibraryViewController *imageLibraryVC = [[ImageLibraryViewController alloc] init];
    imageLibraryVC.delegate = self;
    [self.navigationController pushViewController:imageLibraryVC animated:YES];
    
}




/*- (void) imageLibraryViewController:(ImageLibraryViewController *)imageLibraryViewController didCompleteWithImage:(UIImage *)image {
    [imageLibraryViewController dismissViewControllerAnimated:YES completion:^{
        if (image) {
            NSLog(@"Got an image!");
        } else {
            NSLog(@"Closed without an image.");
        }
    }];
}*

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)viewDidAppear:(BOOL)animated {
   
    if ([[BLCDataSource sharedInstance] userImage]) {
        self.profilePhoto.image = [[BLCDataSource sharedInstance] userImage];
        
    }
}


@end
