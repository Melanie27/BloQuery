//
//  BLCDataSource.m
//  BloQuery
//
//  Created by MELANIE MCGANNEY on 7/15/16.
//  Copyright © 2016 Bloc. All rights reserved.
//

#import "BLCDataSource.h"
#import "Question.h"



@interface BLCDataSource ()

@property (nonatomic, strong) NSArray *questions;
@property (nonatomic, strong) NSDictionary *post;
@property (nonatomic, strong) NSArray *varray;

@end

@implementation BLCDataSource

+ (instancetype) sharedInstance {
    static dispatch_once_t once;
    static id sharedInstance;
    dispatch_once(&once, ^{
        sharedInstance = [[self alloc] init];
            });
    return sharedInstance;
}

- (instancetype) init {
   
    self = [super init];
    
    if (self) {
        [self addRandomQuestion];
        
    }
    
    return self;
}

- (void) addRandomQuestion {
    NSMutableArray *randomQuestions = [NSMutableArray array];
   
    
    for (int i = 1; i <= 7; i++) {
        Question *question = [[Question alloc] init];
        
        question.questionText = [self randomSentence];
         //question.questionText = [self retrieveQuestions];
    
        [randomQuestions addObject:question];
    }
    
    self.questions = randomQuestions;
    [self retrieveQuestions];
    
    
    //start firebase work for adding questions
    
    //[[self.ref child:@"questions/q6"] setValue:@"Who will be at the q6 position"];

    
    
    
}



-(NSString *)retrieveQuestions {
    self.ref = [[FIRDatabase database] reference];
    FIRDatabaseQuery *recentPostsQuery = [[self.ref child:@"questions"] queryLimitedToFirst:7];
   
    NSMutableString *retrieveQuestions = [[NSMutableString alloc] init];
    //NSMutableArray *questionsArray = [[NSMutableArray alloc] init];
    
    [recentPostsQuery
     observeEventType:FIRDataEventTypeValue
     withBlock:^(FIRDataSnapshot *snapshot) {
         NSDictionary *postDict = snapshot.value;
         for (id key in postDict) {
             
             NSArray *questionsArray= [NSArray arrayWithObjects:[postDict objectForKey:key], nil];
             NSLog(@"array, %@", questionsArray);
            
             
         }
         
     }];
    
    
    return retrieveQuestions;
    
    
}



- (NSString *) randomSentence {
    NSUInteger wordCount = arc4random_uniform(20) + 2;
    
    NSMutableString *randomSentence = [[NSMutableString alloc] init];
    
    for (int i  = 0; i <= wordCount; i++) {
        NSString *randomWord = [self randomStringOfLength:arc4random_uniform(12) + 2];
        [randomSentence appendFormat:@"%@ ", randomWord];
    }
    
    return randomSentence;
}

- (NSString *) randomStringOfLength:(NSUInteger) len {
    NSString *alphabet = @"abcdefghijklmnopqrstuvwxyz";
    
    NSMutableString *s = [NSMutableString string];
    for (NSUInteger i = 0U; i < len; i++) {
        u_int32_t r = arc4random_uniform((u_int32_t)[alphabet length]);
        unichar c = [alphabet characterAtIndex:r];
        [s appendFormat:@"%C", c];
    }
    
    return [NSString stringWithString:s];
}


@end
