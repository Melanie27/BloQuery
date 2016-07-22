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
@property (nonatomic, strong) NSString *questionText;


@end

@implementation QuestionTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    //self.wonderfulWizard = [[WizardOfOz alloc] init];
    //Question *newQuestion = [[Question alloc] initWithString:@"Is the next value setting?"];
    //self.questionText = [NSString initWithString:@"Is the next value setting?"];
    //self.question = [[Question alloc] init];
    Question *newQuestion= [[Question alloc] init];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

-(void) addSampleQuestion {
    //start firebase work for adding questions
    //[[self.ref child:@"questionsList/q6"] setValue:@"Who will be at the q6 position"];
    //Question *q = [[Question alloc] initWithQ:@"?" andA:@"answer"];
    //[q.questionText isEqualToString:@"?"];
    
    //NSString *mainCharacter = [self.wonderfulWizard mainCharacter];
    NSString *newQuestion = [self.questionText newQuestion];
    XCTAssertEqualObjects(newQuestion, @"Is the next value setting?", @"Incorrect question string returned.");
    //XCTAssertEqualObjects(mainCharacter, @"Dorothy", @"Incorrect main character string returned.");
}





@end
