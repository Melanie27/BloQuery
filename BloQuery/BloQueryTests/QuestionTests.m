//
//  QuestionTests.m
//  BloQuery
//
//  Created by MELANIE MCGANNEY on 7/21/16.
//  Copyright © 2016 Bloc. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "Question.h"




@interface QuestionTests : XCTestCase

//@property (nonatomic, strong) WizardOfOz *wonderfulWizard;
@property (nonatomic, strong) Question *questionText;


@end

@implementation QuestionTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    
    self.questionText= [[Question alloc] init];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

-(void) addSampleQuestion {
   
    NSString *newQuestion = [self.questionText newQuestion];
    XCTAssertEqualObjects(newQuestion, @"Is the next value setting?", @"Incorrect question string returned.");
   
}

-(void) addSampleQuestion2 {
    
    NSString *newQuestion = [self.questionText newQuestion];
    XCTAssertEqualObjects(newQuestion, @"Is the next value setting2?", @"Incorrect question string returned.");
    
}





@end
