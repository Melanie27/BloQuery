//
//  AnswersTableViewController.m
//  BloQuery
//
//  Created by MELANIE MCGANNEY on 8/2/16.
//  Copyright © 2016 Bloc. All rights reserved.
//

#import "AnswersTableViewController.h"
#import "BLCDataSource.h"
#import "Answer.h"
#import "Question.h"
#import "AnswersTableViewCell.h"
#import "ComposeAnswerViewController.h"
#import "UIColor+BloQueryColors.h"

@interface AnswersTableViewController ()  <UIGestureRecognizerDelegate, UITableViewDelegate, UITableViewDataSource, AnswersTableViewCellDelegate>

@end

@implementation AnswersTableViewController

-(id)initWithStyle:(UITableViewStyle)style {
    
    self = [super initWithStyle:style];
    
    if(self) {
        
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [BLCDataSource sharedInstance].atvc = self;
    [[BLCDataSource sharedInstance] retrieveAnswers];

    //TODO make the header view work and add the _questionAddingTo on top of each answer table
    UIView *questionHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    
    UILabel *questionHeaderLabel = [[UILabel alloc] initWithFrame:CGRectMake(30, 0, 305, 75)];
    [questionHeaderView addSubview:questionHeaderLabel];
    self.tableView.tableHeaderView = questionHeaderView;
    questionHeaderView.backgroundColor = [UIColor myNewColor];
    questionHeaderLabel.backgroundColor = [UIColor yellowColor];
    //NSLog(@"question text %@", self.questionAddingTo);
    questionHeaderLabel.text = [BLCDataSource sharedInstance].question.questionText;
   
    
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
     self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    // Custom initialization, custom nav bar
    //UIImage *logo = [UIImage imageNamed:@"logo.png"];
    //UIImageView *imageView = [[UIImageView alloc] initWithImage:logo];
    //UIBarButtonItem *imageButton = [[UIBarButtonItem alloc] initWithCustomView:imageView];
    //self.navigationItem.leftBarButtonItem = imageButton;
    
    /*UIImage *iconAsk = [UIImage imageNamed:@"iconAsk"];
    UIImageView *askImageView = [[UIImageView alloc] initWithImage:iconAsk];
    UIBarButtonItem *askImageButton = [[UIBarButtonItem alloc] initWithCustomView:askImageView];
    self.navigationItem.rightBarButtonItem = askImageButton;*/
    
    self.navigationItem.title = @"BloQuery Answers";
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//TODO - will I need 2 sections so I can display the question as well?
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [BLCDataSource sharedInstance].answers.count;
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    AnswersTableViewCell *answerCell = [tableView dequeueReusableCellWithIdentifier:@"answerCell" forIndexPath:indexPath];
    answerCell.delegate = self;
    answerCell.answer = [BLCDataSource sharedInstance].answers[indexPath.row];
    
    return answerCell;
}

//Override the default height
-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
    
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

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
