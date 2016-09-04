 //
//  QuestionsTableViewCell.m
//  BloQuery
//
//  Created by MELANIE MCGANNEY on 7/15/16.
//  Copyright © 2016 Bloc. All rights reserved.
//

#import "QuestionsTableViewCell.h"
#import "Question.h"
#import "User.h"
#import "BLCDataSource.h"

@interface QuestionsTableViewCell () <UIGestureRecognizerDelegate>

@end


@implementation QuestionsTableViewCell


-(id) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self) {
        
    }
    
    return self;
}

-(void)viewDidLoad {
    
    
}


//layout views
-(void) layoutSubviews {
    [super layoutSubviews];
    
    if (!self.question) {
        return;
    }
    
}


//override setter method to update the question text whenever a new question is set
-(void)setQuestion:(Question*)question {
    _question = question;
    [self.questionTextView sizeToFit];
    self.questionTextView.text = self.question.questionText;
    
    [self getUserByQuestion];
    
}

-(void)getUserByQuestion {
    User *theUser = [[User alloc] init];
    [[BLCDataSource sharedInstance]retrieveUserWithUID:(NSString*)theUser.uid andCompletion:^(User *user) {
        
    }];
}



@end
