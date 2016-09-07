 //
//  QuestionsTableViewCell.m
//  BloQuery
//
//  Created by MELANIE MCGANNEY on 7/15/16.
//  Copyright © 2016 Bloc. All rights reserved.
//

#import "QuestionsTableViewCell.h"
#import "Question.h"

@interface QuestionsTableViewCell () <UIGestureRecognizerDelegate>

@end


@implementation QuestionsTableViewCell


-(id) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self) {
        
    }
    
    return self;
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
    
}



- (IBAction)didTapProfilePhoto:(id)sender {
    
    NSLog(@"lets see the profile view from here");
}
@end
