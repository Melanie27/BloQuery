//
//  UserProfileViewController.m
//  BloQuery
//
//  Created by MELANIE MCGANNEY on 8/22/16.
//  Copyright © 2016 Bloc. All rights reserved.
//

#import "UserProfileViewController.h"
#import "ImageLibraryViewController.h"

@interface UserProfileViewController () <ImageLibraryViewControllerDelegate>

@end

@implementation UserProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"Your Profile";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//open view to allow user to select photo from image library
- (IBAction)didTapPhotoUpload:(id)sender {
    
    ImageLibraryViewController *imageLibraryVC = [[ImageLibraryViewController alloc] init];
    imageLibraryVC.delegate = self;
    [self.navigationController pushViewController:imageLibraryVC animated:YES];
    NSLog(@"Photo library button pressed.");
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
