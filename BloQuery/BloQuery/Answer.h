//
//  Answer.h
//  BloQuery
//
//  Created by MELANIE MCGANNEY on 7/26/16.
//  Copyright © 2016 Bloc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UpvoteAnswerButton.h"

@interface Answer : NSObject

@property (nonatomic, strong) NSString *answerText;
@property (nonatomic, strong) NSString *temporaryAnswer;
//@property (nonatomic, strong) NSString *answererUID;

@property (nonatomic, assign) LikeState likeState;
@end
