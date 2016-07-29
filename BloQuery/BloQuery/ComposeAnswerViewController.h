//
//  ComposeAnswerViewController.h
//  
//
//  Created by MELANIE MCGANNEY on 7/27/16.
//
//

#import <UIKit/UIKit.h>

@class ComposeAnswerViewController;
@class Question;
@class Answer;
@import FirebaseDatabase;

@protocol ComposeAnswerViewControllerDelegate <NSObject>
- (void) answerViewDidPressAnswerButton:(ComposeAnswerViewController *)sender;

@end

@interface ComposeAnswerViewController : UIViewController

@property (strong, nonatomic) FIRDatabaseReference *ref;

@property (nonatomic, weak) NSObject <ComposeAnswerViewControllerDelegate> *delegate;

@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (nonatomic, assign) BOOL isWritingAnswer;

@property (nonatomic, strong) IBOutlet UILabel *singleQuestionView;
@property (nonatomic, strong) IBOutlet UIButton *deactivateButton;


- (instancetype) initWithQuestion:(Question *)question;

- (IBAction)answerButtonPressed:(id)sender;

- (void) stopComposingAnswer;


@end
