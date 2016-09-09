//
//  AnswersTableViewCell.h
//  BloQuery
//
//  Created by MELANIE MCGANNEY on 8/2/16.
//  Copyright © 2016 Bloc. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Answer, AnswersTableViewCell, Question;
@import FirebaseDatabase;
@import FirebaseStorage;

@protocol AnswersTableViewCellDelegate <NSObject>


@end

@interface AnswersTableViewCell : UITableViewCell
@property (strong, nonatomic) FIRDatabaseReference *ref;
@property (strong, nonatomic) IBOutlet UILabel *answerTextView;
@property (nonatomic, strong) Answer *answer;
@property (nonatomic, assign) NSInteger questionNumber;
@property (nonatomic, assign) NSInteger answerNumber;
@property (nonatomic, strong) NSArray *answers;
@property (nonatomic, assign) NSUInteger answersCount;
@property (strong, nonatomic) IBOutlet UILabel *voteCount;


@property (nonatomic, strong) NSString *answerNumberString;
//- (void) cellDidPressLikeButton:(AnswersTableViewCell *)cell;
- (IBAction)upvoteAnswer:(id)sender;
- (void) cellDidPressUpvoteButton:(AnswersTableViewCell *)answerCell;

@property (nonatomic, weak) id <AnswersTableViewCellDelegate> delegate;

@end
