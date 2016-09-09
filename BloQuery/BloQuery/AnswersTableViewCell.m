//
//  AnswersTableViewCell.m
//  BloQuery
//
//  Created by MELANIE MCGANNEY on 8/2/16.
//  Copyright © 2016 Bloc. All rights reserved.
//

#import "AnswersTableViewCell.h"
#import "Answer.h"
#import "Question.h"
#import "Upvotes.h"
#import "BLCDataSource.h"
#import "ComposeAnswerViewController.h"





@implementation AnswersTableViewCell

-(id) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self) {
        //init code
        
    }
    
    return self;
}




//override setter method to update the answer text whenever a new answer is set
-(void)setAnswer:(Answer*)answer {
    _answer = answer;
    self.answerTextView.text = _answer.answerText;
    
    
   
    
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)upvoteAnswer:(id)sender {
    
    NSLog(@"send upvotes to firebase");
     NSLog(@"answer number2 %ld", (long)self.answerNumber);
     //MOVE TO DATASOURCE once working
    //BLCDataSource *ds = [BLCDataSource sharedInstance];
    //[ds retrieveUpvotes];
    
    
    self.ref = [[FIRDatabase database] reference];
    //Database work here
   
    FIRDatabaseQuery *whichAnswersQuery = [[self.ref child:[NSString stringWithFormat:@"/questions/%ld/answers/%ld/", (long)self.answerNumber, (long)self.questionNumber]] queryLimitedToFirst:1000];
    
    [whichAnswersQuery observeSingleEventOfType:FIRDataEventTypeValue
                                      withBlock:^(FIRDataSnapshot *snapshot) {
                                          
                                          //query how many upvotes there are
                                          
                                          NSLog(@"which answer %ld", (long)self.answerNumber);
                                          
                                          //THIS IS ALWAYS RETURNING THE FIRST ANSWER
                                          NSLog(@"snapshot retrieve answers %@", snapshot.value);
                                          
                                          
                                          Upvotes *upvote = [[Upvotes alloc] init];
                                          upvote.upvotesNumber = snapshot.value[@"upvotes"];
                                          NSInteger retrievingUpvotesInt = [upvote.upvotesNumber integerValue];
                                          NSInteger incrementUpvote = retrievingUpvotesInt + 1;
                                          NSNumber *theUpvotesNumber = @(incrementUpvote);
                                          NSLog(@"new num %@", theUpvotesNumber);
                                          
                                          
                                          
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
    
    
    
}
@end
