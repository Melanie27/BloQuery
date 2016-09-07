//
//  QuestionsTableViewController.h
//  
//
//  Created by MELANIE MCGANNEY on 7/14/16.
//
//

#import <UIKit/UIKit.h>

@class Question;
@class User;
@import Firebase;
@import FirebaseDatabase;


@interface QuestionsTableViewController : UITableViewController <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) Question *question;
@property (nonatomic, assign) NSInteger questionNumber;

- (IBAction)didTapQuestionView:(id)sender;
- (IBAction)didTapProfilePhoto:(id)sender;


//unwind segue implementation
-(IBAction)prepareForUnwind:(UIStoryboardSegue *)segue; 
@end
