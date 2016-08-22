//
//  QuestionsTableViewController.h
//  
//
//  Created by MELANIE MCGANNEY on 7/14/16.
//
//

#import <UIKit/UIKit.h>
#import "Cloudinary/Cloudinary.h"
@class Question;
@import Firebase;
@import FirebaseDatabase;


@interface QuestionsTableViewController : UITableViewController <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) Question *question;
@property (nonatomic, assign) NSInteger questionNumber;

- (IBAction)didTapQuestionView:(id)sender;

// Custom initialization, custom nav bar
//profile button
@property (nonatomic, weak ) IBOutlet UIBarButtonItem  *profileImageButton;


//unwind segue implementation
-(IBAction)prepareForUnwind:(UIStoryboardSegue *)segue; 
@end
