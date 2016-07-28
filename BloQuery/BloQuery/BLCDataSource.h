//
//  BLCDataSource.h
//  BloQuery
//
//  Created by MELANIE MCGANNEY on 7/15/16.
//  Copyright © 2016 Bloc. All rights reserved.
//

#import <Foundation/Foundation.h>
@import FirebaseDatabase;

@class QuestionsTableViewController;
@class Question;
@class Answer;

@interface BLCDataSource : NSObject

@property (strong, nonatomic) FIRDatabaseReference *ref;


//singleton pattern gives the ability to access the same data from multiple places in our database
//to access call [BLCDataSource sharedInstance]
+(instancetype) sharedInstance;
@property (nonatomic, strong, readonly) NSArray<Question *> *questions;
@property (nonatomic, strong, readonly) NSArray *questionsList;
@property (nonatomic, weak) QuestionsTableViewController *qtvc;

@property (nonatomic, strong, readonly) NSArray<Answer*> *answers;

-(NSString *)retrieveQuestions;
-(NSString *)retrieveAnswers;

@end
