//
//  User.m
//  BloQuery
//
//  Created by MELANIE MCGANNEY on 8/22/16.
//  Copyright © 2016 Bloc. All rights reserved.
//

#import "User.h"

@implementation User

- (instancetype) initWithDictionary:(NSDictionary *)userDictionary {
    self = [super init];
    
    if (self) {
        //self.idNumber = userDictionary[@"uid"];
        //self.userEmail = userDictionary[@"email"];
        //self.userDescription = userDictionary[@"description"];
        
        NSString *profileURLString = userDictionary[@"profile_picture"];
        NSURL *profileURL = [NSURL URLWithString:profileURLString];
        
        if (profileURL) {
            //self.profilePictureURL = profileURL;
        }
    }
    
    return self;
}

@end
