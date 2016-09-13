//
//  VIewProfileViewController.m
//  BloQuery
//
//  Created by MELANIE MCGANNEY on 9/1/16.
//  Copyright © 2016 Bloc. All rights reserved.
//

#import "VIewProfileViewController.h"
#import "QuestionsTableViewController.h"
#import "User.h"


@interface VIewProfileViewController ()

@end

@implementation VIewProfileViewController


-(id) initWithUser:(User *)profileUser  {
    self = [super init];
    
    if(self) {
        self.profileUser = profileUser;
       
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"Profile";
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)viewDidAppear:(BOOL)animated {
    
    [self updateUsernameText];
    
    
}

-(void) updateUsernameText {
   
    self.userScreennameLabel.text = self.profileUser.username;
    self.userDescText.text = self.profileUser.userDescription;
    //self.userDescLabel.text = self.profileUser.userDescription;
    self.userPhoto.image = self.profileUser.profilePicture;
    
   
    
}

//override setter method to update the user information whenever a new user is set
-(void)setProfileUser:(User*)profileUser {
    _profileUser = profileUser;
    //NSLog(@"profileuser2 %@", profileUser);
    [self updateUsernameText];
}

@end
