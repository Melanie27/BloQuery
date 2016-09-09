//
//  upvoteButton.m
//  BloQuery
//
//  Created by MELANIE MCGANNEY on 9/9/16.
//  Copyright © 2016 Bloc. All rights reserved.
//

#import "upvoteButton.h"
#define kLikedStateImage @"heart-full"
#define kUnlikedStateImage @"heart-empty"

@implementation upvoteButton

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype) init {
    self = [super init];
    
    if (self) {
        //self.spinnerView = [[CircleSpinnerView alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
        //[self addSubview:self.spinnerView];
        
        self.imageView.contentMode = UIViewContentModeScaleAspectFit;
        
        self.contentEdgeInsets = UIEdgeInsetsMake(10, 10, 10, 10);
        self.contentVerticalAlignment = UIControlContentVerticalAlignmentTop;
        
        self.upvoteButtonState = UpvoteStateNotLiked;
    }
    
    return self;
}

- (void) layoutSubviews {
    [super layoutSubviews];
    //self.spinnerView.frame = self.imageView.frame;
}

- (void) setUpvoteStateButtonState:(UpvoteState)upvoteState {
    _upvoteButtonState = upvoteState;
    
    NSString *imageName;
    
    switch (_upvoteButtonState) {
        case UpvoteStateLiked:
        case UpvoteStateUnliking:
            imageName = kLikedStateImage;
            break;
            
        case UpvoteStateNotLiked:
        case UpvoteStateLiking:
            imageName = kUnlikedStateImage;
    }
    
    switch (_upvoteButtonState) {
        case UpvoteStateLiking:
        case UpvoteStateUnliking:
            //self.spinnerView.hidden = NO;
            self.userInteractionEnabled = NO;
            break;
            
        case UpvoteStateLiked:
        case UpvoteStateNotLiked:
            //self.spinnerView.hidden = YES;
            self.userInteractionEnabled = YES;
    }
    
    
    [self setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
}

@end
