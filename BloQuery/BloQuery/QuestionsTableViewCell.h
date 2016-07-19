//
//  QuestionsTableViewCell.h
//  BloQuery
//
//  Created by MELANIE MCGANNEY on 7/15/16.
//  Copyright © 2016 Bloc. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Question, QuestionsTableViewCell;

@protocol QuestionsTableViewCellDelegate <NSObject>

-(void) cell:(QuestionsTableViewCell *) cell didTapQuestionView:(UILabel *)questionTextView;

@end

@interface QuestionsTableViewCell : UITableViewCell

@property (nonatomic, strong) Question *question;
@property (nonatomic, weak) id <QuestionsTableViewCellDelegate> delegate;

+ (CGFloat) heightForQuestion:(Question *)question width:(CGFloat)width;

@end
