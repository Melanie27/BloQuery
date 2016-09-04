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

@interface UserProfileViewController () <ImageLibraryViewControllerDelegate, UITextViewDelegate, UITextFieldDelegate>
@property (strong, nonatomic) FIRDatabaseReference *ref;

@end

@implementation UserProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    BLCDataSource *ds = [BLCDataSource sharedInstance];
    
    [ds retrieveDescription];
    [ds retrieveScreenName];
    [ds retrievePhotoUrl];
    
    self.navigationItem.title = @"Your Profile";
    self.userDescription.returnKeyType = UIReturnKeyDone;
    self.userDescription.delegate = self;
    self.userName.delegate = self;
    self.userName.returnKeyType = UIReturnKeyDone;

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
        return YES;
    }
    
    return YES;
}

//Enters Optional Screen Name
- (BOOL)textFieldShouldReturn:(UITextField *)theTextField {
    [theTextField resignFirstResponder];
    
    [self sendScreenNameToFirebase];
    return YES;
}

-(void)sendDescToFireBase {
    FIRUser *userAuth = [FIRAuth auth].currentUser;
    self.ref = [[FIRDatabase database] reference];
    
    NSDictionary *descriptionUpdates = @{[NSString stringWithFormat:@"/userData/%@/description/", userAuth.uid]:self.userDescription.text};
    [_ref updateChildValues:descriptionUpdates];
    
    
}

-(void)sendScreenNameToFirebase {
    FIRUser *userAuth = [FIRAuth auth].currentUser;
    self.ref = [[FIRDatabase database] reference];
    
    NSDictionary *screenNameUpdates = @{[NSString stringWithFormat:@"/userData/%@/username/", userAuth.uid]:self.userName.text};
    [_ref updateChildValues:screenNameUpdates];
    
}



//open view to allow user to select photo from image library
- (IBAction)didTapPhotoUpload:(id)sender {
    ImageLibraryViewController *imageLibraryVC = [[ImageLibraryViewController alloc] init];
    imageLibraryVC.delegate = self;
    [self.navigationController pushViewController:imageLibraryVC animated:YES];
    
}

- (IBAction)LogoutUser:(id)sender {
    // [START signout]
    //TODO - TEST IF USER IS SIGNED IN
    NSError *signOutError;
    BOOL status = [[FIRAuth auth] signOut:&signOutError];
    if (!status) {
        NSLog(@"Error signing out: %@", signOutError);
        return;
    } else {
        NSLog(@"signed out");
    }
    // [END signout]
}




/*- (void) imageLibraryViewController:(ImageLibraryViewController *)imageLibraryViewController didCompleteWithImage:(UIImage *)image {
    [imageLibraryViewController dismissViewControllerAnimated:YES completion:^{
        if (image) {
            NSLog(@"Got an image!");
        } else {
            NSLog(@"Closed without an image.");
        }
    }];
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)viewDidAppear:(BOOL)animated {
    BLCDataSource *ds = [BLCDataSource sharedInstance];
    if ([ds userImage]) {
        self.profilePhoto.image = [[BLCDataSource sharedInstance] userImage];
        
    }
    if ([ds userScreenName]) {
        self.userName.text = [[BLCDataSource sharedInstance] userScreenName];
    }
    if ([ds userDesc]) {
        self.userDescription.text = [BLCDataSource sharedInstance].userDesc;
    }
}



@end
