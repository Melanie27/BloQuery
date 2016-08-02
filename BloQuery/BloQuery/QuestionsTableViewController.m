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
#import "ComposeAnswerViewController.h"
@import Firebase;
@import FirebaseDatabase;


@interface QuestionsTableViewController ()  <UIGestureRecognizerDelegate, UITableViewDelegate, UITableViewDataSource, QuestionsTableViewCellDelegate>

@property (nonatomic, strong) UITapGestureRecognizer *tapGesture;
 @property (strong, nonatomic) FIRDatabaseReference *ref;

@property (nonatomic, strong)Question *questionAddingTo;
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
    
    UIImage *iconAsk = [UIImage imageNamed:@"iconAsk"];
    UIImageView *askImageView = [[UIImageView alloc] initWithImage:iconAsk];
    UIBarButtonItem *askImageButton = [[UIBarButtonItem alloc] initWithCustomView:askImageView];
    self.navigationItem.rightBarButtonItem = askImageButton;
    self.navigationItem.title = @"BloQuery";
    
    
    //add tap gesture to right nav button
    UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(addQuestionFired:)];
    [askImageView addGestureRecognizer:tapGes];
    
}

-(void)addQuestionFired:(UITapGestureRecognizer*)sender {
   
    //[self.delegate didTapQuestionButton:askImageButton];
    [[self.ref child:@"questionsList/11"] setValue:@"Who will be at the q11 position"];
    NSLog(@"Add question");
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
    q = [BLCDataSource sharedInstance].questions[indexPath.row];
    QuestionFullScreenViewController *fullScreenVC = [[QuestionFullScreenViewController alloc] initWithQuestion:q];
   [self.navigationController pushViewController:fullScreenVC animated:YES];
    
    
}



#pragma mark - QuestionsTableViewCellDelegate
- (IBAction)didTapQuestionView:(id)sender {
   
    UIButton *theButton = (UIButton *)sender;
    self.questionAddingTo = [BLCDataSource sharedInstance].questions[theButton.tag];
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
