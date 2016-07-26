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

static UIFont *lightFont;
static UIFont *boldFont;
static UIColor *tableBackgroundGray;
static UIColor *linkColor;
static NSParagraphStyle *paragraphStyle;


@implementation QuestionsTableViewCell


-(id) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self) {
        //init code
        self.questionTextView = [[UILabel alloc] init];
        
        self.backgroundColor  = tableBackgroundGray;
        self.questionTextView.backgroundColor = [UIColor whiteColor];
       

        for (UIView *view in @[self.questionTextView]) {
            [self.contentView addSubview:view];
        }
    }
    
    return self;
}


//init the static variables
+(void)load {
    lightFont = [UIFont fontWithName:@"Didot" size:11];
    boldFont = [UIFont fontWithName:@"Didot-Bold" size:11];
    tableBackgroundGray = [UIColor colorWithRed:0.933 green:0.933 blue:0.933 alpha:1]; /*#eeeeee*/
    linkColor = [UIColor colorWithRed:0.345 green:0.314 blue:0.427 alpha:1]; /*#58506d*/
    
    NSMutableParagraphStyle *mutableParagraphStyle = [[NSMutableParagraphStyle alloc] init];
    mutableParagraphStyle.headIndent = 20.0;
    mutableParagraphStyle.firstLineHeadIndent = 20.0;
    mutableParagraphStyle.tailIndent = -50.0;
    mutableParagraphStyle.paragraphSpacingBefore = 10;
    
    paragraphStyle = mutableParagraphStyle;
}


//layout views
-(void) layoutSubviews {
    [super layoutSubviews];
    
    if (!self.question) {
        return;
    }
    
}


-(NSAttributedString *) questionTextString {
    // #1
    CGFloat questionFontSize = 12;
    
    NSString *baseString = [NSString stringWithFormat:@"%@", self.question.questionText];
    
    NSMutableAttributedString *mutableQuestionTextString = [[NSMutableAttributedString alloc] initWithString:baseString attributes:@{NSFontAttributeName : [lightFont fontWithSize:questionFontSize], NSParagraphStyleAttributeName : paragraphStyle }];
    
    NSRange baseStringRange = [baseString rangeOfString:self.question.questionText];
    [mutableQuestionTextString addAttribute:NSForegroundColorAttributeName value:linkColor range:baseStringRange];
    
    return mutableQuestionTextString;
}


//override setter method to update the question text whenever a new question is set
-(void)setQuestion:(Question*)question {
    _question = question;
    self.questionTextView.attributedText = [self questionTextString];
}


@end
