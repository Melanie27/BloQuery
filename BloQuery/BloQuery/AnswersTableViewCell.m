//
//  AnswersTableViewCell.m
//  BloQuery
//
//  Created by MELANIE MCGANNEY on 8/2/16.
//  Copyright © 2016 Bloc. All rights reserved.
//

#import "AnswersTableViewCell.h"
#import "Answer.h"
#import "UpvoteAnswerButton.h"

@interface AnswersTableViewCell()

@property(nonatomic, strong) UpvoteAnswerButton *likeButton;

@end

@implementation AnswersTableViewCell

-(id) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self) {
        //init code
        self.likeButton = [[UpvoteAnswerButton alloc] init];
        //[self.likeButton addTarget:self action:@selector(likePressed:) forControlEvents:UIControlEventTouchUpInside];
        self.likeButton.backgroundColor = [UIColor blueColor];
        
        for (UIView *view in @[self.likeButton]) {
         [self.contentView addSubview:view];
         view.translatesAutoresizingMaskIntoConstraints = NO;
         }

        //adding constraints - why on init?
        NSDictionary *viewDictionary = NSDictionaryOfVariableBindings( _likeButton);
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_likeButton(==38)]|" options:NSLayoutFormatAlignAllTop | NSLayoutFormatAlignAllBottom metrics:nil views:viewDictionary]];
    }
    return self;
}



//override setter method to update the answer text whenever a new answer is set
-(void)setAnswer:(Answer*)answer {
    _answer = answer;
    self.answerTextView.text = self.answer.answerText;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)cellDidPressUpvoteButton:(id)sender {
    NSLog(@"upvote!");
    //increment 1 in FIREBASE
}
@end
