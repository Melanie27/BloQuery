//
//  AnswersTableViewController.h
//  BloQuery
//
//  Created by MELANIE MCGANNEY on 8/2/16.
//  Copyright © 2016 Bloc. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Question;
@import Firebase;
@import FirebaseDatabase;
@interface AnswersTableViewController : UITableViewController <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) Question *question;


@property (nonatomic, strong) IBOutlet UIView *questionHeaderView;
@property (nonatomic, assign) NSInteger answerNumber;
//@property (nonatomic, assign) NSInteger voteNumber;
@property (nonatomic, assign) NSInteger questionNumber;
@property(nonatomic, strong) IBOutlet UILabel *questionHeaderLabel;

@end
