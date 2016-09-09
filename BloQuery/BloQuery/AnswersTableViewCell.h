//
//  AnswersTableViewCell.h
//  BloQuery
//
//  Created by MELANIE MCGANNEY on 8/2/16.
//  Copyright © 2016 Bloc. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Answer, AnswersTableViewCell;
@import FirebaseDatabase;
@import FirebaseStorage;

@protocol AnswersTableViewCellDelegate <NSObject>


@end

@interface AnswersTableViewCell : UITableViewCell
@property (strong, nonatomic) FIRDatabaseReference *ref;
@property (strong, nonatomic) IBOutlet UILabel *answerTextView;
@property (nonatomic, strong) Answer *answer;
@property (nonatomic, assign) NSInteger questionNumber;
@property (nonatomic, strong) NSArray *answers;
@property (nonatomic, assign) NSUInteger answersCount;
//@property (nonatomic, strong) NSNumber *theUpvotesNumber;

@property (nonatomic, strong) NSString *answerNumberString;
@property (nonatomic, assign) NSInteger answerNumber;
- (IBAction)upvoteAnswer:(id)sender;


@property (nonatomic, weak) id <AnswersTableViewCellDelegate> delegate;

@end
