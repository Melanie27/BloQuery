//
//  Questions.h
//  BloQuery
//
//  Created by MELANIE MCGANNEY on 7/15/16.
//  Copyright © 2016 Bloc. All rights reserved.
//

#import <Foundation/Foundation.h>

@class User;

@interface Question : NSObject

@property (nonatomic, strong) User *user;

@property (nonatomic, strong) NSString *questionText;

@end
