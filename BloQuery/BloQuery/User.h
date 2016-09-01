//
//  User.h
//  BloQuery
//
//  Created by MELANIE MCGANNEY on 8/22/16.
//  Copyright © 2016 Bloc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface User : NSObject

@property (nonatomic, strong) NSString *uid;
@property (nonatomic, strong) NSString *description;
@property (nonatomic, strong) NSString *email;
@property (nonatomic, strong) NSString *username;
@property (nonatomic, strong) NSString *profilePictureURL;
@property (nonatomic, strong) UIImage *profilePicture;

@end
