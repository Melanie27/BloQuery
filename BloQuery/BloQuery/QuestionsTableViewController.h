//
//  QuestionsTableViewController.h
//  
//
//  Created by MELANIE MCGANNEY on 7/14/16.
//
//

#import <UIKit/UIKit.h>
@import Firebase;
@import FirebaseDatabase;


@interface QuestionsTableViewController : UITableViewController <UITableViewDelegate, UITableViewDataSource>
+(UIColor *) bloqueryBlue;

- (IBAction)didTapQuestionView:(id)sender;

//unwind segue implementation
-(IBAction)prepareForUnwind:(UIStoryboardSegue *)segue; 
@end
