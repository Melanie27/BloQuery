//
//  QuestionsTableViewController.h
//  
//
//  Created by MELANIE MCGANNEY on 7/14/16.
//
//

#import <UIKit/UIKit.h>

@class Question;
@import Firebase;
@import FirebaseDatabase;


@interface QuestionsTableViewController : UITableViewController <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) Question *question;
@property (nonatomic, assign) NSInteger questionNumber;

- (IBAction)didTapQuestionView:(id)sender;
- (IBAction)didTapProfilePhoto:(id)sender;


@property (nonatomic, weak ) IBOutlet UIBarButtonItem  *profileImageButton;
@property (strong, nonatomic) IBOutlet UIButton *profilePhoto;


//unwind segue implementation
-(IBAction)prepareForUnwind:(UIStoryboardSegue *)segue; 
@end
