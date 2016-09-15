//
//  AnswersTableViewCell.h
//  BloQuery
//
//  Created by MELANIE MCGANNEY on 8/2/16.
//  Copyright © 2016 Bloc. All rights reserved.
//

#import <UIKit/UIKit.h>




@class Answer, AnswersTableViewCell, Question, Upvotes, AnswersTableViewController;
@import FirebaseDatabase;
@import FirebaseStorage;

@protocol AnswersTableViewCellDelegate <NSObject>


@end

@interface AnswersTableViewCell : UITableViewCell

@property (strong, nonatomic) FIRDatabaseReference *ref;
@property (strong, nonatomic) IBOutlet UILabel *answerTextView;
@property (strong, nonatomic) IBOutlet UILabel *voteCountLabel;
@property (nonatomic, strong) Answer *answer;
@property (nonatomic, assign) NSInteger questionNumber;
@property (nonatomic, assign) NSInteger answerNumber;
//@property (nonatomic, assign) NSInteger voteNumber;
@property (nonatomic, strong) NSArray *answers;
//@property (nonatomic, weak) AnswersTableViewController *atvc;

@property (strong, nonatomic) IBOutlet UILabel *voteCount;
@property (nonatomic, strong) NSString *answerNumberString;
@property (strong, nonatomic) IBOutlet UIButton *voteButton;

- (IBAction)upvoteAnswer:(id)sender;


@property (nonatomic, weak) id <AnswersTableViewCellDelegate> delegate;

@end
