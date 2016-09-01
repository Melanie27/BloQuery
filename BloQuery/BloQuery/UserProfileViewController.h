//
//  UserProfileViewController.h
//  BloQuery
//
//  Created by MELANIE MCGANNEY on 8/22/16.
//  Copyright © 2016 Bloc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Cloudinary/Cloudinary.h"



@interface UserProfileViewController : UIViewController

@property (nonatomic, strong) NSString *userDesc;

- (IBAction)didTapPhotoUpload:(id)sender;

@property (strong, nonatomic) IBOutlet UIButton *photoUpload;

@property (strong, nonatomic) IBOutlet UIImageView *profilePhoto;
@property (strong, nonatomic) NSURL *profileURL;
@property (strong, nonatomic) IBOutlet UITextView *userDescription;

@property (strong, nonatomic) IBOutlet UITextField *userName;




@end
