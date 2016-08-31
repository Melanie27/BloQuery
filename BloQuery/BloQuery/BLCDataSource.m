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
#import "UserProfileViewController.h"
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
         if (snapshot.value && [snapshot.value isKindOfClass:[NSArray class]]) {
             for (NSString *a in (NSArray*)snapshot.value) {
                 Answer *answer = [[Answer alloc] init];
                 answer.answerText = a;
                 self.answers = [self.answers arrayByAddingObject:answer];
                 
             }
         }
         [self.atvc.tableView reloadData];
         
     }];
    
    return retrieveAnswers;
}

//user stuff
-(NSString *)retrieveDescription {
     FIRUser *userAuth = [FIRAuth auth].currentUser;
    self.ref = [[FIRDatabase database] reference];
    
    
    FIRDatabaseQuery *getDescQuery = [[self.ref child:[NSString stringWithFormat:@"/userData/%@/", userAuth.uid]] queryLimitedToFirst:10];
     NSMutableString *retrieveDescription = [[NSMutableString alloc] init];
    
    [getDescQuery
     observeEventType:FIRDataEventTypeValue
     withBlock:^(FIRDataSnapshot *snapshot) {
        
         self.userDesc = snapshot.value[@"description"];
         NSLog(@"userDesc %@", snapshot.value);
         
         [self.upvc viewDidLoad];
         //[self.upvc viewWillAppear:YES];
    
    }];
    
    
    return retrieveDescription;
}

-(NSString *)retrieveScreenName {
    FIRUser *userAuth = [FIRAuth auth].currentUser;
    self.ref = [[FIRDatabase database] reference];
    FIRDatabaseQuery *getScreenNameQuery = [[self.ref child:[NSString stringWithFormat:@"/userData/%@", userAuth.uid]] queryLimitedToFirst:10];
    NSMutableString *retrieveScreenName = [[NSMutableString alloc] init];
    //log retrieveScreenName
    [getScreenNameQuery
        observeEventType:FIRDataEventTypeValue
        withBlock:^(FIRDataSnapshot *snapshot) {
            self.userScreenName = snapshot.value;
            //NSLog(@"userScreenName %@", snapshot.valueInExportFormat);
        }];
    
    return retrieveScreenName;
}

-(NSString *)retrievePhotoUrl {
    //FIRUser *userAuth = [FIRAuth auth].currentUser;
    self.ref = [[FIRDatabase database] reference];
    NSMutableString *retrievePhotoString = [[NSMutableString alloc] init];
    //FIRDatabaseQuery *getPhotoStringQuery = [[self.ref child:[NSString stringWithFormat:@"/userData/%@", userAuth.uid]] queryLimitedToFirst:1];
    
    
    return retrievePhotoString;
}


@end
