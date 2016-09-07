//
//  AnswersTableViewCell.h
//  BloQuery
//
//  Created by MELANIE MCGANNEY on 8/2/16.
//  Copyright © 2016 Bloc. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Answer, AnswersTableViewCell;

@protocol AnswersTableViewCellDelegate <NSObject>


@end

@interface AnswersTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *answerTextView;
@property (nonatomic, strong) Answer *answer;
@property (nonatomic, weak) id <AnswersTableViewCellDelegate> delegate;


- (IBAction)cellDidPressUpvoteButton:(AnswersTableViewCell *)cell;

@end
