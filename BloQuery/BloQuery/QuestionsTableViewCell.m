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

//other options instead of text view?
@property (nonatomic, strong) UILabel *questionTextView;

@property (nonatomic, strong) UITapGestureRecognizer *tapGestureRecognizer;

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
        
        //add gesture recognizer
        self.questionTextView.userInteractionEnabled = YES;
        self.questionTextView.numberOfLines = 0;
        
        
        self.tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapFired:)];
        self.tapGestureRecognizer.delegate = self;
        
        [self.questionTextView addGestureRecognizer:self.tapGestureRecognizer];
        
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
    
    CGSize sizeOfquestionTextView = [self sizeOfString:self.questionTextView.attributedText];
    self.questionTextView.frame = CGRectMake(0, 0, CGRectGetWidth(self.contentView.bounds), sizeOfquestionTextView.height);
    
    //hide the lines between cells
    self.separatorInset = UIEdgeInsetsMake(0, CGRectGetWidth(self.bounds)/2.0, 0, CGRectGetWidth(self.bounds)/2.0);
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

//calculate size of attributed strings
- (CGSize) sizeOfString:(NSAttributedString *)string {
    CGSize maxSize = CGSizeMake(CGRectGetWidth(self.questionTextView.frame)- 0, 0.0);
    CGRect sizeRect = [string boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin context:nil];
    sizeRect.size.height += 20;
    sizeRect.size.width = 20;
    sizeRect = CGRectIntegral(sizeRect);
    return sizeRect.size;
}

//override setter method to update the question text whenever a new question is set
-(void)setQuestion:(Question*)question {
    _question = question;
    self.questionTextView.attributedText = [self questionTextString];
}


//TODO - calculate height for each question - this is not working

/*+ (CGFloat) heightForQuestion:(Question *)question width:(CGFloat)width {
    
    QuestionsTableViewCell *layoutCell = [[QuestionsTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"layoutCell"];
    //set given width
    layoutCell.frame = CGRectMake(50, 0, (CGFLOAT_MAX)+150, CGFLOAT_MAX );
    
    //give width to each question item
    layoutCell.question = question;
    
    [layoutCell layoutSubviews];
    
    return CGRectGetMaxY(layoutCell.questionTextView.frame);
}*/

#pragma mark - Single Question View

-(void)tapFired:(UITapGestureRecognizer*) sender {
    
    //[self.delegate cell:self didTapQuestionView:self.questionTextView];
    NSLog(@"tapFired");
}

#pragma mark - UIGestureRecognizerDelegate

/*- (BOOL) gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    return self.isEditing == NO;
}*/

@end
