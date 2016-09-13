//
//  AnswersTableViewCell.m
//  BloQuery
//
//  Created by MELANIE MCGANNEY on 8/2/16.
//  Copyright © 2016 Bloc. All rights reserved.
//

#import "AnswersTableViewCell.h"
#import "Answer.h"
#import "Question.h"
#import "Upvotes.h"
//#import "upvoteButton.h"
#import "BLCDataSource.h"
#import "ComposeAnswerViewController.h"
#import "QuestionsTableViewController.h"

@import Firebase;
@import FirebaseDatabase;
@import FirebaseStorage;
@interface AnswersTableViewCell ()

//@property (strong, nonatomic) FIRDatabaseReference *ref;

@end


@implementation AnswersTableViewCell



- (void)viewDidLoad {
    //[super viewDidLoad];
    NSLog(@"view did load");
    self.voteButton.titleLabel.text = @"upvote";
}

- (void)viewDidAppear:(BOOL)animated
{
     self.voteButton.titleLabel.text = @"downvote";
}



//override setter method to update the answer text whenever a new answer is set
-(void)setAnswer:(Answer*)answer {
    _answer = answer;
    self.answerTextView.text = _answer.answerText;
    
}
-(void)setVoteCount:(UILabel *)voteCount {
    
    self.voteCount.text = @"20 votes";
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
_voteCount.text=@"Recording Sound ...";
    // Configure the view for the selected state
}

- (IBAction)upvoteAnswer:(id)sender {
    self.voteCount.text = @"20 votes";
    FIRUser *userAuth = [FIRAuth auth].currentUser;
    self.ref = [[FIRDatabase database] reference];
    
     FIRDatabaseQuery *userLikeStateQuery = [[self.ref child:[NSString stringWithFormat:@"/questions/%ld/answers/%ld/upvoter/", (long)self.questionNumber, (long)self.answerNumber]] queryLimitedToFirst:1000];
   
    [userLikeStateQuery observeSingleEventOfType:FIRDataEventTypeValue
                                      withBlock:^(FIRDataSnapshot *snapshot) {
                                          NSLog(@"user who've liked %@", snapshot.value);
                                          
                                          NSString *regEx = [NSString stringWithFormat:@"%@", userAuth.uid];
                                          //NSLog(@"reg %@", regEx);
                                          
                                          
                                          BOOL exists = [snapshot.value objectForKey:regEx] != nil;
                                          NSLog(@"exist %hhd", exists);
                                          if (exists == 0) {
                                              //YOU CAN UPVOTE
                                              //MOVE TO DATASOURCE once working
                                            
                                              
                                              self.ref = [[FIRDatabase database] reference];
                                              FIRDatabaseQuery *whichAnswersQuery = [[self.ref child:[NSString stringWithFormat:@"/questions/%ld/answers/%ld/", (long)self.questionNumber, (long)self.answerNumber]] queryLimitedToFirst:1000];
                                              
                                              [whichAnswersQuery observeSingleEventOfType:FIRDataEventTypeValue
                                                                                withBlock:^(FIRDataSnapshot *snapshot) {
                                                                                    
                                                                                    Upvotes *upvote = [[Upvotes alloc] init];
                                                                                    upvote.upvotesNumber = snapshot.value[@"upvotes"];
                                                                                    
                                                                                    NSInteger retrievingUpvotesInt = [upvote.upvotesNumber integerValue];
                                                                                    NSInteger incrementUpvote = retrievingUpvotesInt + 1;
                                                                                    NSNumber *theUpvotesNumber = @(incrementUpvote);
                                                                                    NSLog(@"new num %@", theUpvotesNumber);
                                                                                    NSString *voteString = [theUpvotesNumber stringValue];
                                                                                    self.voteCount.text = voteString;
                                                                                    NSLog(@"vote string %@", voteString);
                                                                                    NSDictionary *upvoteUpdates = @{
                                                                                                                    
                                                                                                                    [NSString stringWithFormat:@"/questions/%ld/answers/%ld/upvotes", (long)self.questionNumber, (long)self.answerNumber]:theUpvotesNumber,
                                                                                                                    [NSString stringWithFormat:@"/questions/%ld/answers/%ld/upvoter/%@/", (long)self.questionNumber, (long)self.answerNumber, userAuth.uid]:@"yes"
                                                                                                                    
                                                                                                                    };
                                                                                    
                                                                                    //NSLog(@"new num to push %@", theUpvotesNumber);
                                                                                    //NSLog(@"updates %@", upvoteUpdates);
                                                                                    [_ref updateChildValues:upvoteUpdates ];
                                                                                    //CHANGE APPEARANCE OF BUTTON
                                                                                    
                                                                                    
                                                                                }];
                                          } else {
                                              self.voteButton.titleLabel.text = @"downvote";
                                              NSLog(@"you have already upvoted you can down vote");
                                              self.ref = [[FIRDatabase database] reference];
                                              FIRDatabaseQuery *whichAnswersQuery = [[self.ref child:[NSString stringWithFormat:@"/questions/%ld/answers/%ld/", (long)self.questionNumber, (long)self.answerNumber]] queryLimitedToFirst:1000];
                                              
                                              [whichAnswersQuery observeSingleEventOfType:FIRDataEventTypeValue
                                                                                withBlock:^(FIRDataSnapshot *snapshot) {
                                                                                    
                                                                                    Upvotes *upvote = [[Upvotes alloc] init];
                                                                                    upvote.upvotesNumber = snapshot.value[@"upvotes"];
                                                                                    
                                                                                    NSInteger retrievingUpvotesInt = [upvote.upvotesNumber integerValue];
                                                                                    NSInteger decrementUpvote = retrievingUpvotesInt - 1;
                                                                                    NSNumber *theUpvotesNumber = @(decrementUpvote);
                                                                                    
                                                                                    
                                                                                    
                                                                                    
                                                                                    NSDictionary *upvoteUpdates = @{
                                                                                                                    
                                                                                                                    [NSString stringWithFormat:@"/questions/%ld/answers/%ld/upvotes", (long)self.questionNumber, (long)self.answerNumber]:theUpvotesNumber,
                                                                                                                    //[NSString stringWithFormat:@"/questions/%ld/answers/%ld/upvoter/%@/", (long)self.questionNumber, (long)self.answerNumber, userAuth.uid]:@"0"
                                                                                                                    
                                                                                                                    };
                                                                                    
                                                                                    
                                                                                    [_ref updateChildValues:upvoteUpdates ];
                                                                                 //get a reference to the UID and remove that child node
                                                                 FIRDatabaseQuery *userQuery = [[self.ref child:[NSString stringWithFormat:@"/questions/%ld/answers/%ld/upvoter/%@/", (long)self.questionNumber, (long)self.answerNumber, userAuth.uid]] queryLimitedToFirst:1];
                                                                                    NSLog(@"user quer %@", userQuery);
                                                                                     [self.ref child:@"upvoter"];
                                                                                     [self.ref child:userAuth.uid];
                                                                                    NSLog(@" remove %@ ", [self.ref child:userAuth.uid] );
                                                                                     NSLog(@" remove %@ ", [[self.ref child:[NSString stringWithFormat:@"/questions/%ld/answers/%ld/upvoter/%@/", (long)self.questionNumber, (long)self.answerNumber, userAuth.uid]] queryLimitedToFirst:1] );
                                                                                    
                                                                                    [[self.ref child:[NSString stringWithFormat:@"/questions/%ld/answers/%ld/upvoter/%@/", (long)self.questionNumber, (long)self.answerNumber, userAuth.uid]] removeValue];
                                                                                    
                                                                                }];
                                          }
                                         
                                          
                                           }];
    
    
    
    //TODO - HIDE UPVOTE BUTTON
    
    
}
@end
