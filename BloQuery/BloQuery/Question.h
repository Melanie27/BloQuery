//
//  Question.h
//  BloQuery
//
//  Created by MELANIE MCGANNEY on 7/15/16.
//  Copyright © 2016 Bloc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Question : NSObject

@property (nonatomic, assign) NSInteger *questionNumber;
@property (nonatomic, strong) NSString *questionText;
@property (nonatomic, strong) NSString *askerUID;

- (NSString *) newQuestion;
@end
