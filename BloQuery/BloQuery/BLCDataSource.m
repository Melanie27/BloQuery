//
//  BLCDataSource.m
//  BloQuery
//
//  Created by MELANIE MCGANNEY on 7/15/16.
//  Copyright © 2016 Bloc. All rights reserved.
//

#import "BLCDataSource.h"
#import "Question.h"
#import "QuestionsTableViewController.h"
#import "Answer.h"


@interface BLCDataSource ()

@property (nonatomic, strong) NSArray *questions;
@property (nonatomic, strong) NSArray *answers;

@end

@implementation BLCDataSource

+ (instancetype) sharedInstance {
    static dispatch_once_t once;
    static id sharedInstance;
    dispatch_once(&once, ^{
        sharedInstance = [[self alloc] init];
            });
    return sharedInstance;
}

- (instancetype) init {
   
    self = [super init];
    
    if (self) {
        
    }
    
    return self;
}



-(NSString *)retrieveQuestions {
    self.ref = [[FIRDatabase database] reference];

    FIRDatabaseQuery *recentPostsQuery = [[self.ref child:@"questionList"] queryLimitedToFirst:1000];
    NSMutableString *retrieveQuestions = [[NSMutableString alloc] init];
    
    
    [recentPostsQuery
     observeEventType:FIRDataEventTypeValue
     withBlock:^(FIRDataSnapshot *snapshot) {
        
         //init the array
         self.questions = @[];
         for (NSString *q in (NSArray*)snapshot.value) {
             Question *question = [[Question alloc] init];
             question.questionText = q;
             self.questions = [self.questions arrayByAddingObject:question];
         }
         [self.qtvc.tableView reloadData];

     }];
    
    return retrieveQuestions;
    
    
}


/*-(NSString *)retrieveAnswers {
    self.ref = [[FIRDatabase database] reference];
    //Database work here
    
    
    return retrieveAnswers;
}*/


@end
