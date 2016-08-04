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
#import "ComposeAnswerViewController.h"
#import "AnswersTableViewController.h"
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
    FIRDatabaseQuery *getQuestionQuery = [[self.ref queryOrderedByChild:@"/questions/"]queryLimitedToFirst:1000];
    NSMutableString *retrievedQuestions = [[NSMutableString alloc] init];
    
    [getQuestionQuery
     observeEventType:FIRDataEventTypeValue
     withBlock:^(FIRDataSnapshot *snapshot) {
         NSLog(@"key: %@, value: %@", snapshot.key, snapshot.value);
         //init the array
         self.questions = @[];
         NSInteger numQuestions = [snapshot.value[@"questions"] count];
         for (NSInteger i = 0; i < numQuestions; i++) {
             Question *question = [[Question alloc] init];
             question.questionText = snapshot.value[@"questions"][i][@"question"];
             self.questions = [self.questions arrayByAddingObject:question];
         }
         [self.qtvc.tableView reloadData];
         [self.cavc.singleQuestionView reloadInputViews];

     }];
    
     return retrievedQuestions;
    
    
}

-(NSString *)retrieveAnswers {
    self.ref = [[FIRDatabase database] reference];
    //Database work here
    
    FIRDatabaseQuery *getAnswersQuery = [[self.ref child:[NSString stringWithFormat:@"/questions/%ld/answers/", (long)self.questionNumber]] queryLimitedToFirst:1000];
    
    NSMutableString *retrieveAnswers = [[NSMutableString alloc] init];
    
    [getAnswersQuery
     observeEventType:FIRDataEventTypeValue
     withBlock:^(FIRDataSnapshot *snapshot) {
         
         self.answers = @[];
         
         for (NSString *a in (NSArray*)snapshot.value) {
             Answer *answer = [[Answer alloc] init];
             answer.answerText = a;
             self.answers = [self.answers arrayByAddingObject:answer];
             
         }
         [self.atvc.tableView reloadData];
         
     }];
    
    return retrieveAnswers;
}


@end
