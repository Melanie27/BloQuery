//
//  BLCDataSource.h
//  BloQuery
//
//  Created by MELANIE MCGANNEY on 7/15/16.
//  Copyright © 2016 Bloc. All rights reserved.
//

#import <Foundation/Foundation.h>
@import FirebaseDatabase;

@class QuestionsTableViewController;

@interface BLCDataSource : NSObject

@property (strong, nonatomic) FIRDatabaseReference *ref;


//singleton pattern gives the ability to access the same data from multiple places in our database
//to access call [BLCDataSource sharedInstance]
+(instancetype) sharedInstance;
@property (nonatomic, strong, readonly) NSArray *questions;
@property (nonatomic, strong, readonly) NSArray *questionsList;
@property (nonatomic, weak) QuestionsTableViewController *qtvc;

-(NSString *)retrieveQuestions;

@end
