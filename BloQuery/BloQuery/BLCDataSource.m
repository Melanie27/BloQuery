//
//  BLCDataSource.m
//  BloQuery
//
//  Created by MELANIE MCGANNEY on 7/15/16.
//  Copyright © 2016 Bloc. All rights reserved.
//

#import "BLCDataSource.h"
#import "Question.h"
#import "QuestionsTableViewController.h"
#import "ComposeAnswerViewController.h"
#import "AnswersTableViewController.h"
#import "UserProfileViewController.h"
#import "VIewProfileViewController.h"
#import "Answer.h"
#import "User.h"
#import "Upvotes.h"

@interface BLCDataSource ()

@property (nonatomic, strong) NSArray *questions;
@property (nonatomic, strong) NSArray *answers;
@property (nonatomic, strong) NSNumber *theUpvotesNumber;
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
        
    }
    
    return self;
}



-(NSString *)retrieveQuestions {
    
    self.ref = [[FIRDatabase database] reference];
    
    FIRDatabaseQuery *getQuestionQuery = [[self.ref queryOrderedByChild:@"/questions/"]queryLimitedToFirst:1000];
    NSMutableString *retrievedQuestions = [[NSMutableString alloc] init];
    
    [getQuestionQuery
     observeEventType:FIRDataEventTypeValue
     withBlock:^(FIRDataSnapshot *snapshot) {
         //init the array
         self.questions = @[];
         NSInteger numQuestions = [snapshot.value[@"questions"] count];
         for (NSInteger i = 0; i < numQuestions; i++) {
             Question *question = [[Question alloc] init];
             question.questionText =    snapshot.value[@"questions"][i][@"question"];
             question.askerUID =        snapshot.value[@"questions"][i][@"UID"];
             self.questions = [self.questions arrayByAddingObject:question];
         }
         [self.qtvc.tableView reloadData];
         [self.cavc.singleQuestionView reloadInputViews];
         
     }];
    
   
    return retrievedQuestions;

}

-(NSNumber *) retrieveUpvotes {
    NSNumber *retrieveUpvotes  = [[NSNumber alloc] init];
    
    self.ref = [[FIRDatabase database] reference];
    //Database work here
    //MOVE TO DATASOURCE???
    FIRDatabaseQuery *whichAnswersQuery = [[self.ref child:[NSString stringWithFormat:@"/questions/%ld/answers/%ld/", (long)self.answerNumber, (long)self.questionNumber]] queryLimitedToFirst:1000];
    
    [whichAnswersQuery observeSingleEventOfType:FIRDataEventTypeValue
                                      withBlock:^(FIRDataSnapshot *snapshot) {
                                          
                                          //query how many upvotes there are
                                          
                                          //NSLog(@"which question %ld", (long)self.questionNumber);
                                          
                                          //THIS IS ALWAYS RETURNING THE FIRST ANSWER
                                          NSLog(@"snapshot retrieve answers %@", snapshot.value[@"upvotes"]);
                                          
                                          
                                          Upvotes *upvote = [[Upvotes alloc] init];
                                          upvote.upvotesNumber = snapshot.value[@"upvotes"];
                                          NSInteger retrievingUpvotesInt = [upvote.upvotesNumber integerValue];
                                          NSInteger incrementUpvote = retrievingUpvotesInt + 1;
                                          NSNumber *theUpvotesNumber = @(incrementUpvote);
                                          //NSLog(@"new num %@", theUpvotesNumber);
                                          
                                          
                                          
                                          NSDictionary *answerObject = (NSDictionary*)snapshot.value;
                                            if (!(answerObject && [answerObject isKindOfClass:[NSDictionary class]])) {
                                                answerObject = @{snapshot.key:snapshot.value};
                                           
                                               
                                                
                                                NSArray *answerListing = [answerObject objectForKey:snapshot.key];
                                                for (NSDictionary *answerDict in answerListing) {
                                           
                                           
                                                                                                       
                                                    //Upvotes *upvote = [[Upvotes alloc] init];
                                                    //upvote.upvotesNumber = answerDict[@"upvotes"];
                                                    //NSInteger retrievingUpvotesInt = [upvote.upvotesNumber integerValue];
                                                    //NSInteger incrementUpvote = retrievingUpvotesInt + 1;
                                                    //NSNumber *theUpvotesNumber = @(incrementUpvote);
                                                    //NSLog(@"new num %@", theUpvotesNumber);
                                           
                                            }
                                                
                                               
                                                
                                            //TODO Answer Number variable must find which answer has been clicked
                                                //CURRENTLY only able to upvote the first answer
                                           
                                           
                                    }
                                          
                                          NSDictionary *upvoteUpdates = @{
                                                                          
                                                                          [NSString stringWithFormat:@"/questions/%ld/answers/%ld/upvotes", (long)self.questionNumber, (long)self.answerNumber]:theUpvotesNumber,
                                                                          
                                                                          };
                                          
                                          NSLog(@"new num to push %@", theUpvotesNumber);
                                          NSLog(@"updates %@", upvoteUpdates);
                                          [_ref updateChildValues:upvoteUpdates ];
                                          
                                          
                            }];
    
    
   
    
    return retrieveUpvotes;
}


-(NSString *)retrieveAnswers {
    NSMutableString *retrieveAnswers = [[NSMutableString alloc] init];

    self.ref = [[FIRDatabase database] reference];
    //Database work here
     FIRDatabaseQuery *getAnswersQuery2 = [[self.ref child:[NSString stringWithFormat:@"/questions/%ld/answers/", (long)self.questionNumber]] queryLimitedToFirst:1000];
   
    
    //NSLog(@"num of answers %ld", (long)self.answerNumber);
    
    [getAnswersQuery2
     observeEventType:FIRDataEventTypeValue
     withBlock:^(FIRDataSnapshot *snapshot) {
          NSLog(@"getans %ld", (long)self.questionNumber);
         //self.questionNumber
               self.answers = @[];
               
               //NSLog(@"snapshot retrieve answers %@", snapshot.value);
               
               NSDictionary *answerObject = (NSDictionary*)snapshot.value;
               if (!(answerObject && [answerObject isKindOfClass:[NSDictionary class]])) {
                   answerObject = @{snapshot.key:snapshot.value};
                   
                   NSArray *answerListing = [answerObject objectForKey:snapshot.key];
                   for (NSDictionary *answerDict in answerListing) {
                       Answer *answer = [[Answer alloc] init];
                       answer.answerText = answerDict[@"answer"];
                       
                       self.answers = [self.answers arrayByAddingObject:answer];
                       
                   }
   
               }
        
         
         if (self.atvc && self.atvc.tableView) {
             dispatch_async(dispatch_get_main_queue(), ^{
                 [self.atvc.tableView reloadData];
             });
         }
     }];
    
    
    
    
    return retrieveAnswers;
}


//user stuff
-(NSString *)retrieveDescription {
    FIRUser *userAuth = [FIRAuth auth].currentUser;
    self.ref = [[FIRDatabase database] reference];
    
    FIRDatabaseQuery *getDescQuery = [[self.ref child:[NSString stringWithFormat:@"/userData/%@/", userAuth.uid]] queryLimitedToFirst:10];
    NSMutableString *retrieveDescription = [[NSMutableString alloc] init];
    
    [getDescQuery
     observeEventType:FIRDataEventTypeValue
     withBlock:^(FIRDataSnapshot *snapshot) {
         
         if ([snapshot.value isKindOfClass:[NSDictionary class]]) {
             self.userDesc = snapshot.value[@"description"];
         }
         
         [self.upvc viewWillAppear:YES];
         
     }];
    
    
    return retrieveDescription;
}

-(NSString *)retrieveDescriptionWithUID:(NSString *)uid andCompletion:(RetrievalCompletionBlock)completion {
    //FIRUser *userAuth = [FIRAuth auth].currentUser;
    self.ref = [[FIRDatabase database] reference];
    
    FIRDatabaseQuery *getDescQuery = [[self.ref child:[NSString stringWithFormat:@"/userData/%@/", uid]] queryLimitedToFirst:10];
    NSMutableString *retrieveDescription = [[NSMutableString alloc] init];
    
    [getDescQuery
     observeEventType:FIRDataEventTypeValue
     withBlock:^(FIRDataSnapshot *snapshot) {
         
         if ([snapshot.value isKindOfClass:[NSDictionary class]]) {
             completion((NSDictionary*)snapshot.value);
             
             //             self.userDesc = snapshot.value[@"description"];
         }
         
         //        [self.upvc viewWillAppear:YES];
         
     }];
    
    
    return retrieveDescription;
}


-(NSString *)retrieveScreenNameWithUID:(NSString *)uid andCompletion:(RetrievalCompletionBlock)completion {
    User *theUser = [[User alloc] init];
     //NSLog(@"screen name uid %@", uid);
    self.ref = [[FIRDatabase database] reference];
    FIRDatabaseQuery *getScreenNameQuery = [[self.ref child:[NSString stringWithFormat:@"/userData/%@", theUser.uid]] queryLimitedToFirst:10];
    NSMutableString *retrieveScreenName = [[NSMutableString alloc] init];
    
    [getScreenNameQuery
     observeEventType:FIRDataEventTypeValue
     withBlock:^(FIRDataSnapshot *snapshot) {
         if ([snapshot.value isKindOfClass:[NSDictionary class]]) {
             completion((NSDictionary*)snapshot.value);
             //NSLog(@"screen name snapshot %@", snapshot);
         }
     }];
    
    return retrieveScreenName;
}


-(NSString *)retrieveScreenName {
    FIRUser *userAuth = [FIRAuth auth].currentUser;
    self.ref = [[FIRDatabase database] reference];
    FIRDatabaseQuery *getScreenNameQuery = [[self.ref child:[NSString stringWithFormat:@"/userData/%@", userAuth.uid]] queryLimitedToFirst:10];
    NSMutableString *retrieveScreenName = [[NSMutableString alloc] init];
    
    [getScreenNameQuery
     observeEventType:FIRDataEventTypeValue
     withBlock:^(FIRDataSnapshot *snapshot) {
         if ([snapshot.value isKindOfClass:[NSDictionary class]]) {
             
             self.userScreenName = snapshot.value[@"username"];
             
             [self.upvc viewWillAppear:YES];
         }
     }];
    
    return retrieveScreenName;
}


-(NSString *)retrievePhotoUrlWithUID:(NSString *)uid andCompletion:(RetrievalCompletionBlock)completion {
    User *theUser = [[User alloc] init];
    NSLog(@"view all uid %@", theUser);
    self.ref = [[FIRDatabase database] reference];
    NSMutableString *retrievePhotoString = [[NSMutableString alloc] init];
    FIRDatabaseQuery *getPhotoStringQuery = [[self.ref child:[NSString stringWithFormat:@"/userData/YWrq5DwsJse46yZ3xNuefUUtYBL2"]] queryLimitedToFirst:10];
   // NSLog(@"theUser %@", theUser.uid);
    [getPhotoStringQuery
     observeEventType:FIRDataEventTypeValue
     withBlock:^(FIRDataSnapshot *snapshot) {
         if ([snapshot.value isKindOfClass:[NSDictionary class]]) {
             completion((NSDictionary*)snapshot.value);
             theUser.uid = snapshot.value[@"uid"];
            theUser.profilePictureURL = snapshot.value[@"profile_picture"];
              //NSLog(@"uid %@", theUser.uid);
             
              [self.upvc viewWillAppear:YES];
             
         }
     }];
    
    
    return retrievePhotoString;
}


-(NSString *)retrievePhotoUrl {
    FIRUser *userAuth = [FIRAuth auth].currentUser;
    self.ref = [[FIRDatabase database] reference];
    NSMutableString *retrievePhotoString = [[NSMutableString alloc] init];
    FIRDatabaseQuery *getPhotoStringQuery = [[self.ref child:[NSString stringWithFormat:@"/userData/%@", userAuth.uid]] queryLimitedToFirst:10];
    
    [getPhotoStringQuery
     observeEventType:FIRDataEventTypeValue
     withBlock:^(FIRDataSnapshot *snapshot) {
         if ([snapshot.value isKindOfClass:[NSDictionary class]]) {
             //THIS IS THE STRING TO THE IMAGE WE WANT TO SEE
             self.userImageString = snapshot.value[@"profile_picture"];
           
             FIRStorage *storage = [FIRStorage storage];
             FIRStorageReference *httpsReference = [storage referenceForURL:self.userImageString];
            
             
             [httpsReference downloadURLWithCompletion:^(NSURL* URL, NSError* error){
                 if (error != nil) {
                     NSLog(@"download url error");
                 } else {
                     //NSLog(@"no download url error %@", URL);
                     NSData *imageData = [NSData dataWithContentsOfURL:URL];
                     self.userImage = [UIImage imageWithData:imageData];
                 }
                 
             }];
             
            
             
             [self.upvc viewDidAppear:YES];
            
         }
     }];
    
    
    return retrievePhotoString;
}

-(void)retrieveUserWithUID:(NSString *)uid andCompletion:(UserRetrievalCompletionBlock)completion {
    User *theUser = [[User alloc] init];
    //theUser.profilePictureURL = @"";
    //theUser.username = @"";
    //theUser.userDescription = @"";
    //theUser.email = @"";
    //theUser.uid = @"";
    
    self.ref = [[FIRDatabase database] reference];
   
    
    
  FIRDatabaseQuery *getUserInfoQuery = [[self.ref child:[NSString stringWithFormat:@"/userData/%@/", uid]] queryLimitedToFirst:10];
    [getUserInfoQuery
     observeEventType:FIRDataEventTypeValue
     withBlock:^(FIRDataSnapshot *snapshot) {
        
         
        theUser.profilePictureURL = snapshot.value[@"profile_picture"];
        theUser.username = snapshot.value[@"username"];
        theUser.email = snapshot.value[@"email"];
        theUser.userDescription = snapshot.value[@"description"];
        theUser.uid = snapshot.value[@"uid"];
         
            FIRStorage *storage = [FIRStorage storage];
            FIRStorageReference *httpsReference = [storage referenceForURL:theUser.profilePictureURL];
                      
                      
            [httpsReference downloadURLWithCompletion:^(NSURL* URL, NSError* error){
                if (error != nil) {
                    NSLog(@"download url error");
                } else {
                    //NSLog(@"no download url error %@", URL);
                    NSData *imageData = [NSData dataWithContentsOfURL:URL];
                    theUser.profilePicture = [UIImage imageWithData:imageData];
                   
                    completion(theUser);
                }
                          
            }];
                      
 
             
         
     }];
}
@end