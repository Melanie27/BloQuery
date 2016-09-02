//
//  QuestionsTableViewController.m
//  
//
//  Created by MELANIE MCGANNEY on 7/14/16.
//
//

#import <UIKit/UIKit.h>
#import <SDWebImage/UIImageView+WebCache.h>

#import "QuestionsTableViewController.h"
#import "BLCDataSource.h"
#import "Question.h"
#import "QuestionsTableViewCell.h"
#import "QuestionFullScreenViewController.h"
#import "AnswersTableViewController.h"
#import "ComposeAnswerViewController.h"
#import "UserProfileViewController.h"
#import "SCLAlertView.h"
#import "User.h"

@import Firebase;
@import FirebaseDatabase;
@import FirebaseStorage;


@interface QuestionsTableViewController ()  <UIGestureRecognizerDelegate, UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITapGestureRecognizer *tapGesture;
 @property (strong, nonatomic) FIRDatabaseReference *ref;
@property (strong, nonatomic) FIRStorage *storageRef;

@property (nonatomic, strong)Question *questionAddingTo;

@property (nonatomic, strong)UITextField *postQuestionTextField;


@end

@implementation QuestionsTableViewController


//Override the table view controller's initializer to create an empty array
- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {

    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [BLCDataSource sharedInstance].qtvc = self;
    [[BLCDataSource sharedInstance] retrieveQuestions];

    // Custom initialization, custom nav bar
    UIImage *profileImage = [UIImage imageNamed:@"logo.png"];
    UIImageView *profileImageView = [[UIImageView alloc] initWithImage:profileImage];
    UIBarButtonItem *profileImageButton = [[UIBarButtonItem alloc] initWithCustomView:profileImageView];
    self.navigationItem.leftBarButtonItem = profileImageButton;
    
    UIImage *iconAsk = [UIImage imageNamed:@"iconAsk.png"];
    UIImageView *askImageView = [[UIImageView alloc] initWithImage:iconAsk];
    UIBarButtonItem *askImageButton = [[UIBarButtonItem alloc] initWithCustomView:askImageView];
    self.navigationItem.rightBarButtonItem = askImageButton;
    self.navigationItem.title = @"BloQuery Questions";
    
    
    //add tap gesture to right nav button
    UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(addQuestionFired:)];
    [askImageView addGestureRecognizer:tapGes];
    
    
    //add tap gesture to profile nav button
    UITapGestureRecognizer *tappedProfile = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(customizeProfileFired:)];
    [profileImageView addGestureRecognizer:tappedProfile];
    
}

-(void)customizeProfileFired:(UITapGestureRecognizer*)sender {
    
        UserProfileViewController *userProfileVC = [self.storyboard instantiateViewControllerWithIdentifier:@"profileView"];
        [self.navigationController pushViewController:userProfileVC animated:YES];
    }
    
    

-(void)addQuestionFired:(UITapGestureRecognizer*)sender {
    SCLAlertView *alert = [[SCLAlertView alloc] init];
    alert.backgroundViewColor = [UIColor colorWithRed:252.0/255.0 green:181.0/255.0 blue:23.0/255.0 alpha:1.0];
    
    UITextField *postQuestionTextField = [alert addTextField:@"Enter Your Question"];
    [alert addCustomView:postQuestionTextField];
    
    [alert showCustom:self image:[UIImage imageNamed:@"popIcon.png"] color:[UIColor colorWithRed:0.0/255.0 green:122.0/255.0 blue:255.0/255.0 alpha:1.0] title:@"Ask a Question" subTitle:@"Ex: Is calling my cat a 'monster' bad for its self esteem? Or is it good?" closeButtonTitle:@"Post" duration:0.0f]; // Custom
    
    alert.shouldDismissOnTapOutside = YES;
    
    //TODO question number is always zero
    NSArray *questionsArray = [BLCDataSource sharedInstance].questions;
    [BLCDataSource sharedInstance].questionNumber = [questionsArray indexOfObject:_question];
   
   
    [alert alertIsDismissed:^{
        
        NSString *code = [postQuestionTextField.text copy];
        self.ref = [[FIRDatabase database] reference];
        FIRUser *userAuth = [FIRAuth auth].currentUser;
        NSDictionary *childUpdates = @{
                                       
                                       [NSString stringWithFormat:@"/questions/%ld/question/", (unsigned long)[BLCDataSource sharedInstance].questions.count]:code,
                                       [NSString stringWithFormat:@"/questions/%ld/UID/", (unsigned long)[BLCDataSource sharedInstance].questions.count]:userAuth.uid
                                       };
       
        [_ref updateChildValues:childUpdates];
        
        
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [BLCDataSource sharedInstance].questions.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
   QuestionsTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.delegate = self;
   
    cell.question = [BLCDataSource sharedInstance].questions[indexPath.row];
   
    UIButton *button = [UIButton buttonWithType:UIButtonTypeContactAdd];
    [button addTarget:self action:@selector(didTapQuestionView:) forControlEvents:UIControlEventTouchDown];
    button.tag = indexPath.row;
    cell.accessoryView = button;
    
    //SDImage stuff here
    // Here we use the new provided sd_setImageWithURL: method to load the web image
    //[cell.imageView sd_setImageWithURL:[NSURL URLWithString:@"http://www.domain.com/path/to/image.jpg"]
                      //placeholderImage:[UIImage imageNamed:@"placeholder.png"]];

    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    Question *q;
    NSInteger row = indexPath.row;
    BLCDataSource *ds = [BLCDataSource sharedInstance];
    q = [BLCDataSource sharedInstance].questions[row];
    self.questionAddingTo = [BLCDataSource sharedInstance].questions[row];
    ds.questionNumber = row;
    ds.question = self.questionAddingTo;

}

#pragma mark - Tap the Profile Image on a given Question
-(IBAction)didTapProfilePhoto:(id)sender {
    NSLog(@"tapped profile photo");
        //BLCDataSource *ds = [BLCDataSource sharedInstance];
    
        //UIButton *theButton = (UIButton *)sender;
        //self.questionAddingTo = [BLCDataSource sharedInstance].questions[theButton.tag];
       //ds.questionNumber = theButton.tag;
       //ds.question = self.questionAddingTo;
        //[self performSegueWithIdentifier:@"viewProfile" sender:self];
}


#pragma mark - QuestionsTableViewCellDelegate
- (IBAction)didTapQuestionView:(id)sender {
    BLCDataSource *ds = [BLCDataSource sharedInstance];

    UIButton *theButton = (UIButton *)sender;
    self.questionAddingTo = [BLCDataSource sharedInstance].questions[theButton.tag];
    ds.questionNumber = theButton.tag;
    ds.question = self.questionAddingTo;

    [self performSegueWithIdentifier:@"composeAnswer" sender:self];
    
}



- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender  {
    return YES;
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{

    if([segue.identifier isEqualToString:@"composeAnswer"])
    {
        ComposeAnswerViewController *composeAnswerVC = (ComposeAnswerViewController*)segue.destinationViewController;
        composeAnswerVC.question = self.questionAddingTo;
        
    } else if([segue.identifier isEqualToString:@"showAnswers"]){
        
    } else if ([segue.identifier isEqualToString:@"updatePofile"]) {
        //UserProfileViewController *userProfileVC = (UserProfileViewController*)segue.destinationViewController;

    } else if ([segue.identifier isEqualToString:@"viewProfile"]) {
                NSLog(@"view a profile view controller");

    }
}
    




//unwind segue implementation
-(IBAction)prepareForUnwind:(UIStoryboardSegue *)segue {
    
}


//Override the default height
-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
   
}


/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
 } else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }
 */

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

/*
 #pragma mark - Navigation
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */


@end
