//
//  ComposeAnswerViewController.m
//  
//
//  Created by MELANIE MCGANNEY on 7/27/16.
//
//

#import "ComposeAnswerViewController.h"
#import "Question.h"
#import "Answer.h"

@interface ComposeAnswerViewController () <UITextViewDelegate>
@property (nonatomic, strong) Question *question;
@property (nonatomic, strong) NSArray *answers;
@property (nonatomic, assign) NSUInteger answersCount;
@property (nonatomic, assign) NSUInteger answersCountIncrement;
@property (nonatomic, strong) NSString *answerNumberString;

@end

@implementation ComposeAnswerViewController

-(instancetype) initWithQuestion:(Question *)question {
    self = [super init];
    
    if(self) {
        self.question = question;
    }
    
    return self;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    
   
    self.textView.delegate = self;
    self.deactivateButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    self.singleQuestionView = [UILabel new];
    self.singleQuestionView.text = self.question.questionText;
    [self.textView addSubview:self.singleQuestionView];

    

}


-(void) viewWillLayoutSubviews {
    
   
        self.textView.backgroundColor = [UIColor whiteColor];
        [self.textView becomeFirstResponder];
    
        
    }




-(NSAttributedString *) singleQuestionTextString {

    NSMutableAttributedString *mutableQuestionTestString = [[NSMutableAttributedString alloc] init];
    return mutableQuestionTestString;
}


//override setter method to update the question text whenever a new question is set
-(void)setQuestion:(Question*)question {
    _question = question;
    self.singleQuestionView.attributedText = [self singleQuestionTextString];
    
}


//dismiss the keyboard when this method is called
- (IBAction)answerButtonPressed:(id)sender {
    self.textView.backgroundColor = [UIColor blackColor];
    [self.textView resignFirstResponder];
    
   
    //send answer to firebase
   
    
    self.ref = [[FIRDatabase database] reference];
    FIRDatabaseQuery *answersQuery = [[self.ref child:@"answersList"] queryLimitedToFirst:1000];
    
    [answersQuery observeEventType:FIRDataEventTypeValue
                     withBlock:^(FIRDataSnapshot *snapshot) {
                         NSLog(@"%@ -> %@", snapshot.key, snapshot.value);
                         
                         self.answers = @[];
                         for (NSString *a in (NSArray*)snapshot.value) {
                             Answer *answer = [[Answer alloc] init];
                             answer.answerText = a;
                             self.answers = [self.answers arrayByAddingObject:answer];
                             
                         }
                         
                         self.answersCount = self.answers.count;
                         NSLog(@"count %lu", (unsigned long)self.answersCount);
                         self.answersCountIncrement = self.answersCount + 1;
                         NSLog(@"count %lu", (unsigned long)self.answersCountIncrement);
                         
                         NSString *answerNumberString = [NSString stringWithFormat:@"%lu", (unsigned long)self.answersCountIncrement];
                         
    }];
    
    
    NSString *key = [[_ref child:@"answerList"] childByAutoId].key;
    //this number should be a variable that counts how many answers there are and adds 1
    
    NSLog(@"answers %@", answersQuery);
    NSDictionary *post = @{@"answerNumberString": self.textView.text};
     NSDictionary *childUpdates = @{[@"/posts/" stringByAppendingString:key]: post,
     [NSString stringWithFormat:@"/answersList/3"]: post};
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
