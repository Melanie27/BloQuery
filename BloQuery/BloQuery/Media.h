//
//  Media.h
//  BloQuery
//
//  Created by MELANIE MCGANNEY on 7/15/16.
//  Copyright © 2016 Bloc. All rights reserved.
//

#import <UIKit/UIKit.h>


@class User;


@interface Media : NSObject

@property (nonatomic, strong) NSString *idNumber;
//@property (nonatomic, strong) User *user;
@property (nonatomic, strong) NSURL *mediaURL;
@property (nonatomic, strong) UIImage *image;
@property (nonatomic, strong) NSString *caption;
@property (nonatomic, strong) NSArray *comments;

@end
