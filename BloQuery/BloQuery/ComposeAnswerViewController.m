//
//  ComposeAnswerViewController.m
//  
//
//  Created by MELANIE MCGANNEY on 7/27/16.
//
//

#import "ComposeAnswerViewController.h"
#import "BLCDataSource.h"
#import "Question.h"
#import "Answer.h"

@interface ComposeAnswerViewController () <UITextViewDelegate>
@property (nonatomic, strong) NSArray *answers;
@property (nonatomic, assign) NSUInteger answersCount;
@property (nonatomic, strong) NSString *answerNumberString;

@end

@implementation ComposeAnswerViewController

-(instancetype) init {
    self = [super init];
    
    if(self) {

    }
    
    return self;
}

-(id) initWithQuestion:(Question *)question  {
    self = [super init];
    
    if(self) {
        self.question = question;
    }
    
    return self;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    
   
    [BLCDataSource sharedInstance].cavc = self;
    [[BLCDataSource sharedInstance] retrieveQuestions];
    
    self.deactivateButton = [UIButton buttonWithType:UIButtonTypeCustom];

    [self updateQuestionLabel];
   
}


-(void) viewWillLayoutSubviews {
    
        self.textView.backgroundColor = [UIColor whiteColor];
        [self.textView becomeFirstResponder];
    
}

-(void) updateQuestionLabel {
    self.singleQuestionView.text = self.question.questionText;
   //TODO set the question number here
    //1. get the array of questions
    //2. get the index
    //3. convert index to integer
    //4. assign the integer to questionNumber variable
    //5. put questionNumber variable in the url

    NSArray *questionsArray = [BLCDataSource sharedInstance].questions;
    self.questionNumber = [questionsArray indexOfObject:_question];
    
}


//dismiss the keyboard when this method is called
- (IBAction)answerButtonPressed:(id)sender {
    self.textView.backgroundColor = [UIColor blackColor];
    [self.textView resignFirstResponder];
    
    //send answer to firebase
    
    
    self.ref = [[FIRDatabase database] reference];
    FIRDatabaseQuery *answersQuery = [[self.ref child:[NSString stringWithFormat:@"/questions/%ld/answers/", (long)self.questionNumber]] queryLimitedToFirst:1000];
    
    
    [answersQuery observeSingleEventOfType:FIRDataEventTypeValue
                         withBlock:^(FIRDataSnapshot *snapshot) {
                             self.answers = @[];
                             for (NSString *a in (NSArray*)snapshot.value) {
                                 Answer *answer = [[Answer alloc] init];
                                 answer.answerText = a;
                                 self.answers = [self.answers arrayByAddingObject:answer];
                             }
                             
                             self.answersCount = self.answers.count;
                             self.answerNumberString = [NSString stringWithFormat:@"%lu", (unsigned long)self.answersCount];
                            
                             [self sendToFireBase];
                         }];
    
    
}

-(void)sendToFireBase {
   
   
    NSString *key = [[_ref child:@"answerList"] childByAutoId].key;
    
    //NSDictionary *post = @{@"answer": self.textView.text};
    NSDictionary *childUpdates = @{
                                   //[@"/posts/" stringByAppendingString:key]: post,
                                   //TODO set this url up with DB
                                   [NSString stringWithFormat:@"/questions/%ld/answers/%@", (long)self.questionNumber, self.answerNumberString]: self.textView.text
                                   };
    [_ref updateChildValues:childUpdates];

}


- (BOOL)textViewShouldEndEditing:(UITextView *)textView {
    BOOL hasAnswer = (textView.text.length > 0);
    [self setIsWritingAnswer:hasAnswer];
    
    return YES;
}




/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


@end
