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

-(instancetype) init {
    self = [super init];
    
    if(self) {
        
    }
    
    return self;
}

-(id) initWithUser:(User *)profileUser  {
    self = [super init];
    
    if(self) {
        self.profileUser = profileUser;
        NSLog(@"profile user %@", profileUser);
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
    [self setUser:_profileUser];
    [self updateUsernameText];
    
}

-(void) updateUsernameText {
    self.userScreenName.text = self.profileUser.username;
    self.userDescText.text = self.profileUser.userDescription;
    self.userPhoto.image = self.profileUser.profilePicture;
   
    
}

//override setter method to update the user information whenever a new user is set
-(void)setUser:(User*)profileUser {
    _profileUser = profileUser;
    NSLog(@"profileuser %@", profileUser);

}

@end
