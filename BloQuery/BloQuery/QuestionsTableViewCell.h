//
//  QuestionsTableViewCell.h
//  BloQuery
//
//  Created by MELANIE MCGANNEY on 7/15/16.
//  Copyright © 2016 Bloc. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Question, QuestionsTableViewCell, User;

@protocol QuestionsTableViewCellDelegate <NSObject>


@end

@interface QuestionsTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *questionTextView;
@property (nonatomic, strong) Question *question;
@property (nonatomic, strong) User *asker;
@property (nonatomic, strong) IBOutlet UIButton *profilePhoto;

@property (nonatomic, weak) id <QuestionsTableViewCellDelegate> delegate;



@end
