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
    //TODO change this query to the "questions" table, crashing every time I try
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
         [self.cavc.singleQuestionView reloadInputViews];

     }];
    
    return retrieveQuestions;
    
    
}

-(NSString *)retrieveAnswers {
    self.ref = [[FIRDatabase database] reference];
    //Database work here
    
    //NSArray *questionsArray = [BLCDataSource sharedInstance].questions;
    //self.questionNumber = [questionsArray indexOfObject:_question];
    
    
    /*FIRDatabaseQuery *getQuestionsQuery = [[self.ref child:[NSString stringWithFormat:@"/questions/%ld/question/", (long)self.questionNumber]] queryLimitedToFirst:1000];
   
    [getQuestionsQuery
        observeEventType:FIRDataEventTypeValue
        withBlock:^(FIRDataSnapshot *snapshot) {
            self.questions = @[];
             NSLog(@"questions query %@", self.questions);
    }];*/
    
    
    
    FIRDatabaseQuery *getAnswersQuery = [[self.ref child:[NSString stringWithFormat:@"/questions/%ld/answers/", (long)self.questionNumber]] queryLimitedToFirst:1000];
    
    
    NSLog(@"question number %ld", self.questionNumber );
   
    NSMutableString *retrieveAnswers = [[NSMutableString alloc] init];
    
    [getAnswersQuery
     observeEventType:FIRDataEventTypeValue
     withBlock:^(FIRDataSnapshot *snapshot) {
         //this logs all answers to question 1
         NSLog(@"snapshot %@", snapshot.value);
         
         self.answers = @[];
         
         for (NSString *a in (NSArray*)snapshot.value) {
             Answer *answer = [[Answer alloc] init];
             answer.answerText = a;
             self.answers = [self.answers arrayByAddingObject:answer];
             NSLog(@"answers thru loop %@", self.answers);
             
         }
         [self.atvc.tableView reloadData];
         
     }];
    
    return retrieveAnswers;
}


@end
