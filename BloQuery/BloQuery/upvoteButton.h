//
//  upvoteButton.h
//  BloQuery
//
//  Created by MELANIE MCGANNEY on 9/9/16.
//  Copyright © 2016 Bloc. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, UpvoteState) {
    UpvoteStateNotLiked             = 0,
    UpvoteStateLiking               = 1,
    UpvoteStateLiked                = 2,
    UpvoteStateUnliking             = 3
};

@interface upvoteButton : UIButton

@property (nonatomic, assign) UpvoteState upvoteButtonState;

@end
