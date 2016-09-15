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
#import "BLCDataSource.h"
#import "ComposeAnswerViewController.h"
#import "QuestionsTableViewController.h"

@import Firebase;
@import FirebaseDatabase;
@import FirebaseStorage;



@implementation AnswersTableViewCell



- (void)viewDidLoad {
    //[super viewDidLoad];
    
    }




//override setter method to update the answer text whenever a new answer is set
-(void)setAnswer:(Answer*)answer {
    _answer = answer;
    self.answerTextView.text = _answer.answerText;
    self.voteCountLabel.text = [NSString stringWithFormat:@"%d",_answer.upvotes];
    
    
    
}

- (void) viewWillAppear:(BOOL)animated {
    UITableView *tableView = (UITableView *)self.superview.superview;
    [tableView reloadData];
    [self superview];
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
          
        
        NSUInteger upvoteUIDCount = (unsigned long)snapshot.childrenCount;                                   
        NSString *regEx = [NSString stringWithFormat:@"%@", userAuth.uid];
        
        //TODO if there are 0 upvoters it is impossible to upvote
        BOOL exists = [snapshot.value objectForKey:regEx] != nil;
                                           
        if (exists == 0) {
    // Add Vote
            
            self.ref = [[FIRDatabase database] reference];
            FIRDatabaseQuery *whichAnswersQuery = [[self.ref child:[NSString stringWithFormat:@"/questions/%ld/answers/%ld/", (long)self.questionNumber, (long)self.answerNumber]] queryLimitedToFirst:1000];
                                               
            [whichAnswersQuery observeSingleEventOfType:FIRDataEventTypeValue
            withBlock:^(FIRDataSnapshot *snapshot) {
                                                                                     
                
                NSInteger retrievingUpvotesInt = upvoteUIDCount;
                NSInteger incrementUpvote = retrievingUpvotesInt + 1;
                NSNumber *theUpvotesNumber = @(incrementUpvote);
                                                                                     
                NSDictionary *upvoteUpdates = @{
                                                                                                                     
                    [NSString stringWithFormat:@"/questions/%ld/answers/%ld/upvotes", (long)self.questionNumber, (long)self.answerNumber]:theUpvotesNumber,
                    [NSString stringWithFormat:@"/questions/%ld/answers/%ld/upvoter/%@/", (long)self.questionNumber, (long)self.answerNumber, userAuth.uid]:@"yes"
                                                                                                                     
                                            };
                                                                                     
                                                                                    
                [_ref updateChildValues:upvoteUpdates ];
               
                [self.voteButton setTitle:@"downvote" forState:UIControlStateNormal];
                [self.voteButton setNeedsLayout];
                                                                                     
            }];
            
            
        } else {
// Remove Vote
                                               
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
                                                                                                                     
                    
                };
                
                [_ref updateChildValues:upvoteUpdates ];
                //get a reference to the UID and remove that child node
                                                                                     
                [[self.ref child:[NSString stringWithFormat:@"/questions/%ld/answers/%ld/upvoter/%@/", (long)self.questionNumber, (long)self.answerNumber, userAuth.uid]] removeValue];
                
                [self.voteButton setTitle:@"upvote" forState:UIControlStateNormal];
                
                [self.voteButton setNeedsLayout];
                
            }];
        }
                                       
         
    }];
    
}
@end
