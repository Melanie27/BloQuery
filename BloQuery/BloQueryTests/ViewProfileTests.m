//
//  ViewProfileTests.m
//  BloQuery
//
//  Created by MELANIE MCGANNEY on 9/8/16.
//  Copyright © 2016 Bloc. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "VIewProfileViewController.h"
//#import "BLCDataSource.h"
#import "User.h"

@interface ViewProfileTests : XCTestCase
+ (void)userWithName:(NSString *)description;
@end

@implementation ViewProfileTests

- (void)setUp {
    [super setUp];
    
    // Put setup code here. This method is called before the invocation of each test method in the class.
    
    // In UI tests it is usually best to stop immediately when a failure occurs.
    self.continueAfterFailure = NO;
    // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
    [[[XCUIApplication alloc] init] launch];

    // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // Use recording to get started writing UI tests.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}

- (void) testViewProfileLabels {
    User *shortDescription = [User userWithName:@"John Francis 'Jack' Donaghy" description:@"Vice President of East Coast Television and Microwave Oven Programming for General Electric"];
    User *longDescription = [User userWithName:@"Scrooge McDuck" description:@"Scrooge is an elderly Scottish anthropomorphic Pekin Duck with a yellow-orange bill, legs, and feet. He typically wears a red or blue frock coat, top hat, pince-nez glasses, and spats and is portrayed in animations as speaking with a slight Scottish accent, also sometimes known as a Scottish burr. His dominant character trait is his thrift, and within the context of the fictional Disney universe, he is the world's richest person."];
    
    VIewProfileViewController *shortProfileVC = [[VIewProfileViewController alloc] initWithUser:shortDescription];
    VIewProfileViewController *longProfileVC = [[VIewProfileViewController alloc] initWithUser:longDescription];
    
    // Force the views to load
    [shortProfileVC view];
    [longProfileVC view];
    
    XCTAssertEqualObjects(shortDescription, shortProfileVC.userDescLabel.text);
    XCTAssertEqualObjects(longDescription, longProfileVC.userDescLabel.text);
    
    CGRect expectedLongProfileRect = CGRectMake(44, 100, 200, 600); // Just for example
    XCTAssertTrue(CGRectEqualToRect(expectedLongProfileRect, longProfileVC.userDescLabel.frame));
}

@end
