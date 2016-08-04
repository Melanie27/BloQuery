//
//  QuestionsTableViewController.m
//  
//
//  Created by MELANIE MCGANNEY on 7/14/16.
//
//

#import <UIKit/UIKit.h>
#import "QuestionsTableViewController.h"
#import "BLCDataSource.h"
#import "Question.h"
#import "QuestionsTableViewCell.h"
#import "QuestionFullScreenViewController.h"
#import "AnswersTableViewController.h"
#import "ComposeAnswerViewController.h"
#import "SCLAlertView.h"
@import Firebase;
@import FirebaseDatabase;


@interface QuestionsTableViewController ()  <UIGestureRecognizerDelegate, UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITapGestureRecognizer *tapGesture;
 @property (strong, nonatomic) FIRDatabaseReference *ref;

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
    UIImage *logo = [UIImage imageNamed:@"logo.png"];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:logo];
    UIBarButtonItem *imageButton = [[UIBarButtonItem alloc] initWithCustomView:imageView];
    self.navigationItem.leftBarButtonItem = imageButton;
    
    UIImage *iconAsk = [UIImage imageNamed:@"iconAsk.png"];
    UIImageView *askImageView = [[UIImageView alloc] initWithImage:iconAsk];
    UIBarButtonItem *askImageButton = [[UIBarButtonItem alloc] initWithCustomView:askImageView];
    self.navigationItem.rightBarButtonItem = askImageButton;
    self.navigationItem.title = @"BloQuery";
    
    
    //add tap gesture to right nav button
    UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(addQuestionFired:)];
    [askImageView addGestureRecognizer:tapGes];
    
   
    
}

-(void)addQuestionFired:(UITapGestureRecognizer*)sender {
    SCLAlertView *alert = [[SCLAlertView alloc] init];
    alert.backgroundViewColor = [UIColor colorWithRed:252.0/255.0 green:181.0/255.0 blue:23.0/255.0 alpha:1.0];
    
    //SCLButton *button = [alert addButton:@"First Button" target:self selector:@selector(firstButton)];
    
    [alert addButton:@"Second Button" actionBlock:^(void) {
       
        [self postQuestion];
    
    }];
    
    //TODO size of text field
    
    UITextField *postQuestionTextField = [alert addTextField:@"Enter Your Question"];
    CGRect frameRect = postQuestionTextField.frame;
    frameRect.size.height = 40; // <-- Specify the height you want here.
    postQuestionTextField.frame = frameRect;
    [alert addCustomView:postQuestionTextField];
    
    [alert showCustom:self image:[UIImage imageNamed:@"popIcon.png"] color:[UIColor colorWithRed:0.0/255.0 green:122.0/255.0 blue:255.0/255.0 alpha:1.0] title:@"Ask a Question" subTitle:@"Ex: Is calling my cat a 'monster' bad for its self esteem? Or is it good?" closeButtonTitle:@"Post" duration:0.0f]; // Custom
    
    alert.shouldDismissOnTapOutside = YES;
    
    //TODO send the textfield contents to firebase

    
}

-(void)postQuestion {
     NSLog(@"post question to firebase");
    self.ref = [[FIRDatabase database] reference];
    NSString *key = [[_ref child:@"questionList"] childByAutoId].key;
    NSLog(@"key %@", key);
    
    /*NSDictionary *post = @{@"question": self.postQuestionTextField.text};
    NSDictionary *childUpdates = @{
                                   [@"/posts/" stringByAppendingString:key]: post,
                                   //TODO set this url up with DB
                                   [NSString stringWithFormat:@"/questionsList/"]: post
                                   };
    [_ref updateChildValues:childUpdates];*/
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
        
    } else if([segue.identifier isEqualToString:@"showAnswers"])
    {
        
      //  NSLog(@"questionAddingto %@", self.questionAddingTo);
       // [BLCDataSource sharedInstance].questionNumber = [BLCDataSource sharedInstance].questionNumber;
        //[[[BLCDataSource sharedInstance] questions] indexOfObject:self.questionAddingTo];
        //
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
