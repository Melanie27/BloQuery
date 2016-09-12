//
//  BloQueryUITests.m
//  BloQueryUITests
//
//  Created by MELANIE MCGANNEY on 7/11/16.
//  Copyright © 2016 Bloc. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "User.h"
#import "VIewProfileViewController.h"
//#import "UserProfileViewController.h"

@interface BloQueryUITests : XCTestCase
@property (nonatomic) VIewProfileViewController *viewProfileVC;
@end

@implementation BloQueryUITests
User *shortDescUser;
User *longDescUser;

- (void)setUp {
    [super setUp];
    
    // Put setup code here. This method is called before the invocation of each test method in the class.
    
    // In UI tests it is usually best to stop immediately when a failure occurs.
    self.continueAfterFailure = NO;
    // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
    //[[[XCUIApplication alloc] init] launch];
    
    // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    
    
    shortDescUser = [[User alloc] init];
    shortDescUser.uid = @"";
    shortDescUser.username = @"";
    shortDescUser.userDescription = @"";
    
    longDescUser = [[User alloc] init];
    longDescUser.uid = @"";
    longDescUser.username = @"";
    longDescUser.userDescription = @"";

}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // Use recording to get started writing UI tests.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    XCTAssert(YES,@"");
}

- (void)testViewProfileLabels {
    
    
    
    VIewProfileViewController *shortProfileVC = [[VIewProfileViewController alloc] init];
    [shortProfileVC view];
    shortProfileVC.profileUser = shortDescUser;
    
    VIewProfileViewController *longProfileVC = [[VIewProfileViewController alloc] init];
    [longProfileVC view];
    longProfileVC.profileUser = longDescUser;
    
    
    XCTAssertEqualObjects(shortDescUser.userDescription, shortProfileVC.userDescText.text);
    XCTAssertEqualObjects(longDescUser.userDescription, longProfileVC.userDescText.text);
    
    CGRect expectedLongProfileRect = CGRectMake(44, 100, 200, 600); // Just for example
    XCTAssertTrue(CGRectEqualToRect(expectedLongProfileRect, longProfileVC.userDescText.frame));
}

@end
