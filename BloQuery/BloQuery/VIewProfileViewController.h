//
//  VIewProfileViewController.h
//  BloQuery
//
//  Created by MELANIE MCGANNEY on 9/1/16.
//  Copyright © 2016 Bloc. All rights reserved.
//

#import "UserProfileViewController.h"
#import "User.h"

@interface VIewProfileViewController : UserProfileViewController
//@property (strong, nonatomic) IBOutlet UITextView *userDesc;
@property (strong, nonatomic) IBOutlet UITextField *userScreenName;
@property (strong, nonatomic) IBOutlet UIImageView *userPhoto;
@property (strong, nonatomic) IBOutlet UITextView *userDescText;



@property (nonatomic, strong) User *profileUser;
//@property (nonatomic, strong) User *user;

- (instancetype) initWithUser:(User *)profileUser;

@end
