//
//  BLCDataSource.h
//  BloQuery
//
//  Created by MELANIE MCGANNEY on 7/15/16.
//  Copyright © 2016 Bloc. All rights reserved.
//

#import <UIKit/UIKit.h>
@import FirebaseDatabase;
@import FirebaseStorage;

@class QuestionsTableViewController;
@class ComposeAnswerViewController;
@class AnswersTableViewController;
@class UserProfileViewController;
@class VIewProfileViewController;
@class Question;
@class Answer;
@class User;
@class Upvotes;

typedef void(^RetrievalCompletionBlock)(NSDictionary *snapshotValue);
typedef void(^UserRetrievalCompletionBlock)(User *user);

@interface BLCDataSource : NSObject

@property (strong, nonatomic) FIRDatabaseReference *ref;


//singleton pattern gives the ability to access the same data from multiple places in our database
//to access call [BLCDataSource sharedInstance]
+(instancetype) sharedInstance;
@property (nonatomic, strong, readonly) NSArray<Question *> *questions;
@property (nonatomic, strong, readonly) NSArray<Answer*> *answers;
@property (nonatomic, strong) NSArray<Upvotes*> *upvotes;

@property (nonatomic, weak) QuestionsTableViewController *qtvc;
@property (nonatomic, weak) AnswersTableViewController *atvc;
@property (nonatomic, weak) ComposeAnswerViewController *cavc;
@property (nonatomic, weak) UserProfileViewController *upvc;


@property (nonatomic, strong) NSString *voteCount;
@property (nonatomic, strong) Question *question;
@property (nonatomic, assign) NSInteger questionNumber;
@property (nonatomic, strong) Answer *answer;
@property (nonatomic, assign) NSInteger answerNumber;
@property (nonatomic, strong) Upvotes *upvote;
@property (nonatomic, assign) NSInteger voteNumber;
@property (strong) UIImage *userImage;
@property (nonatomic, strong) NSString *userDesc;
@property (nonatomic, weak) NSString *userScreenName;
@property (nonatomic, weak) NSString *userImageString;
//@property (nonatomic, strong) NSNumber *theUpvotesNumber;
-(NSString *)retrieveQuestions;
-(NSString *)retrieveAnswers;
-(NSNumber *)retrieveVotes;
-(NSString *)retrieveDescription;
-(NSString *)retrieveDescriptionWithUID:(NSString*)uid andCompletion:(RetrievalCompletionBlock)completion;
-(NSString *)retrieveScreenName;
-(NSString *)retrieveScreenNameWithUID:(NSString*)uid andCompletion:(RetrievalCompletionBlock)completion;
-(NSString *)retrievePhotoUrl;
-(NSString *)retrievePhotoUrlWithUID:(NSString*)uid andCompletion:(RetrievalCompletionBlock)completion;
-(void)retrieveUserWithUID:(NSString *)uid andCompletion:(UserRetrievalCompletionBlock)completion;

@end
