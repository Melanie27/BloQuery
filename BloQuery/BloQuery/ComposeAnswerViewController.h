//
//  ComposeAnswerViewController.h
//  
//
//  Created by MELANIE MCGANNEY on 7/27/16.
//
//

#import <UIKit/UIKit.h>
#import "QuestionsTableViewController.h"

@class ComposeAnswerViewController;
@class Question;
@class Answer;
@import FirebaseDatabase;

@protocol ComposeAnswerViewControllerDelegate <NSObject>


@end

@interface ComposeAnswerViewController : UIViewController

@property (strong, nonatomic) FIRDatabaseReference *ref;
@property (nonatomic, strong) Question *question;
@property (nonatomic, assign) NSInteger questionNumber;
@property (nonatomic, assign) NSInteger answerNumber;

@property (nonatomic, weak) NSObject <ComposeAnswerViewControllerDelegate> *delegate;

@property (nonatomic, assign) BOOL isWritingAnswer;

@property (nonatomic, strong) IBOutlet UILabel *singleQuestionView;
@property (nonatomic, strong) IBOutlet UIButton *deactivateButton;
@property (weak, nonatomic) IBOutlet UITextView *textView;



- (instancetype) initWithQuestion:(Question *)question;

- (IBAction)answerButtonPressed:(id)sender;




@end
