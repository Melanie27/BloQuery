//
//  BLCDataSource.h
//  BloQuery
//
//  Created by MELANIE MCGANNEY on 7/15/16.
//  Copyright © 2016 Bloc. All rights reserved.
//

#import <UIKit/UIKit.h>
@import FirebaseDatabase;

@class QuestionsTableViewController;
@class ComposeAnswerViewController;
@class AnswersTableViewController;
@class UserProfileViewController;
@class Question;
@class Answer;

@interface BLCDataSource : NSObject

@property (strong, nonatomic) FIRDatabaseReference *ref;


//singleton pattern gives the ability to access the same data from multiple places in our database
//to access call [BLCDataSource sharedInstance]
+(instancetype) sharedInstance;
@property (nonatomic, strong, readonly) NSArray<Question *> *questions;
@property (nonatomic, strong, readonly) NSArray<Answer*> *answers;

@property (nonatomic, weak) QuestionsTableViewController *qtvc;
@property (nonatomic, weak) AnswersTableViewController *atvc;
@property (nonatomic, weak) ComposeAnswerViewController *cavc;
@property (nonatomic, weak) UserProfileViewController *upvc;


@property (nonatomic, strong) Question *question;
@property (nonatomic, assign) NSInteger questionNumber;
@property (strong) UIImage *userImage;
@property (nonatomic, weak) NSString *userDesc;
-(NSString *)retrieveQuestions;
-(NSString *)retrieveAnswers;
-(NSString *)retrieveDescription;
-(NSString *)retrieveScreenName;
-(NSString *)retrieveProfileUrl;

@end
