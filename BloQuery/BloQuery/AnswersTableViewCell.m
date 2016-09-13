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
#import "upvoteButton.h"
#import "BLCDataSource.h"
#import "ComposeAnswerViewController.h"
#import "QuestionsTableViewController.h"

@import Firebase;
@import FirebaseDatabase;
@import FirebaseStorage;
//@interface AnswersTableViewCell : UITableViewCell

//@property (nonatomic, strong) UpvoteButton *upvoteButton;

//@end


@implementation AnswersTableViewCell

-(id) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self) {
        //init code
        
    }
    
    return self;
}




//override setter method to update the answer text whenever a new answer is set
-(void)setAnswer:(Answer*)answer {
    _answer = answer;
    self.answerTextView.text = _answer.answerText;
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)upvoteAnswer:(id)sender {
    
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
                                              //BLCDataSource *ds = [BLCDataSource sharedInstance];
                                              //[ds retrieveAnswers];
                                              
                                              self.ref = [[FIRDatabase database] reference];
                                              
                                              
                                              FIRDatabaseQuery *whichAnswersQuery = [[self.ref child:[NSString stringWithFormat:@"/questions/%ld/answers/%ld/", (long)self.questionNumber, (long)self.answerNumber]] queryLimitedToFirst:1000];
                                              
                                              [whichAnswersQuery observeSingleEventOfType:FIRDataEventTypeValue
                                                                                withBlock:^(FIRDataSnapshot *snapshot) {
                                                                                    
                                                                                    Upvotes *upvote = [[Upvotes alloc] init];
                                                                                    upvote.upvotesNumber = snapshot.value[@"upvotes"];
                                                                                    
                                                                                    NSInteger retrievingUpvotesInt = [upvote.upvotesNumber integerValue];
                                                                                    NSInteger incrementUpvote = retrievingUpvotesInt + 1;
                                                                                    NSNumber *theUpvotesNumber = @(incrementUpvote);
                                                                                    //NSLog(@"new num %@", theUpvotesNumber);
                                                                                    
                                                                                    NSDictionary *upvoteUpdates = @{
                                                                                                                    
                                                                                                                    [NSString stringWithFormat:@"/questions/%ld/answers/%ld/upvotes", (long)self.questionNumber, (long)self.answerNumber]:theUpvotesNumber,
                                                                                                                    [NSString stringWithFormat:@"/questions/%ld/answers/%ld/upvoter/%@/", (long)self.questionNumber, (long)self.answerNumber, userAuth.uid]:@"yes"
                                                                                                                    
                                                                                                                    };
                                                                                    
                                                                                    //NSLog(@"new num to push %@", theUpvotesNumber);
                                                                                    //NSLog(@"updates %@", upvoteUpdates);
                                                                                    [_ref updateChildValues:upvoteUpdates ];
                                                                                    
                                                                                    
                                                                                }];
                                          } else {
                                              
                                              NSLog(@"you have already upvoted you can down vote");
                                          }
                                         
                                          
                                           }];
    
    
    
    //TODO - HIDE UPVOTE BUTTON
    
    
}
@end
