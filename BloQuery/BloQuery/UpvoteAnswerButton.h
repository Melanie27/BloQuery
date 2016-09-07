//
//  UpvoteAnswerButton.h
//  
//
//  Created by MELANIE MCGANNEY on 9/7/16.
//
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, LikeState) {
    LikeStateNotLiked             = 0,
    LikeStateLiking               = 1,
    LikeStateLiked                = 2,
    LikeStateUnliking             = 3
};

@interface UpvoteAnswerButton : UIButton

//this property indicates the current state of the button
@property (nonatomic, assign) LikeState likeButtonState;

@end
