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
   
    
    
    
}
-(void)setUpvotes:(Upvotes*)upvotes {
    _upvotes = upvotes;
    self.voteCountLabel.text = _upvotes.upvotesNumberString;
    
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
   
    //TODO move to datasource
    BLCDataSource *ds = [BLCDataSource sharedInstance];
    [ds upvoteCounting];
    
    
    
    
    
    //TODO - HIDE UPVOTE BUTTON
    
    
}
@end
