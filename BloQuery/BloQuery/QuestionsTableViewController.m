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
@import Firebase;
@import FirebaseDatabase;


@interface QuestionsTableViewController ()  <UITableViewDelegate, UITableViewDataSource, QuestionsTableViewCellDelegate>

//@property (nonatomic, strong) NSArray *questions;


@end

@implementation QuestionsTableViewController

//Override the table view controller's initializer to create an empty array
- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
        //self.questions = [NSArray array];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //populate viewDidLoad with strings
    /*self.questions = [NSArray arrayWithObjects:@"Is this the first question?", @"How many characters will move a question onto another row This many or will the text just keep getting smaller? ", @"Tuesday",@"Wednesday",@"Thursday",@"Friday",@"Saturday",nil];*/
    
    
    [self.tableView registerClass:[QuestionsTableViewCell class] forCellReuseIdentifier:@"Cell"];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    //return self.questions.count;
    return [BLCDataSource sharedInstance].questions.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
   QuestionsTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    cell.delegate = self;
    
    cell.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    //
    
    //cell.textLabel.minimumScaleFactor = 0.6;
    //cell.textLabel.adjustsFontSizeToFitWidth = YES;
    //cell.textLabel.text = [self.questions objectAtIndex:indexPath.row];
    
    //placeholder thumbnail
    //cell.imageView.image = [UIImage imageNamed:@"3.jpg"];
    
    
    
    /*self.firebaseRef = [[Firebase alloc] initWithUrl:@"https://bloquery-e361d.firebaseio.com/"];
    self.dataSource = [[FirebaseTableViewDataSource alloc] initWithRef:firebaseRef cellReuseIdentifier:@"cell" view:self.tableView];
    
    [self.dataSource populateCellWithBlock:^(UITableViewCell *cell, FDataSnapshot *snap) {
        // Populate cell as you see fit, like as below
        cell.textLabel.text = snap.key;
    }];
    
    [self.tableView setDataSource:self.dataSource];*/

    
    
    
  
    cell.question = [BLCDataSource sharedInstance].questions[indexPath.row];
    return cell;
}

#pragma mark - QuestionsTableViewCellDelegate

- (void) cell:(QuestionsTableViewCell *)cell didTapQuestionView:(UITextView *)textView {
    QuestionFullScreenViewController *fullScreenVC = [[QuestionFullScreenViewController alloc] initWithQuestion:cell.question];
    
    [self presentViewController:fullScreenVC animated:YES completion:nil];
}

//override the default width


//Override the default height
-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    return 100;
    //UILabel *question = [BLCDataSource sharedInstance].questions[indexPath.row];
    /*CGSize labelSize = [question.text
                        boundingRectWithSize:question.frame.size
                        options:NSStringDrawingUsesLineFragmentOrigin
                        context:nil]
    .size.width;*/
    //CGFloat labelHeight = labelSize.height;
    
    //return labelHeight;
    
    
    
    
    
    
}



  //Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the specified item to be editable.
 return NO;
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
