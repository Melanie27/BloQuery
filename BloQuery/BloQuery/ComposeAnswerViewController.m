//
//  ComposeAnswerViewController.m
//  
//
//  Created by MELANIE MCGANNEY on 7/27/16.
//
//

#import "ComposeAnswerViewController.h"
#import "Question.h"

@interface ComposeAnswerViewController () <UITextViewDelegate>
@property (nonatomic, strong) Question *question;
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
    
    self.singleQuestionView = [[UILabel alloc] init];
    self.singleQuestionView.text = self.question.questionText;
    

}


-(void) viewWillLayoutSubviews {
    
    if(self.isWritingAnswer) {
        self.textView.backgroundColor = [UIColor whiteColor];
        
    } else {
        [self.textView becomeFirstResponder];
        self.textView.backgroundColor = [UIColor purpleColor];
       
    }
    
    [self.view addSubview:self.singleQuestionView];
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
    
    if (self.isWritingAnswer) {
        [self.textView resignFirstResponder];
        self.textView.userInteractionEnabled = NO;
        [self.delegate answerViewDidPressAnswerButton:self];
        
    } else {
        [self setIsWritingAnswer:YES];
        [self.textView becomeFirstResponder];
    }
    
    
    //send answer to firebase
    //capture the text
    NSLog (@"capture text: %@", self.textView.text);
    self.ref = [[FIRDatabase database] reference];

    /*NSString *key = [[_ref child:@"questionList"] childByAutoId].key;
     NSDictionary *post = @{@"uid": userID,
     @"body": body};
     NSDictionary *childUpdates = @{[@"/posts/" stringByAppendingString:key]: post,
     [NSString stringWithFormat:@"/user-posts/%@/%@/", userID, key]: post};
     [_ref updateChildValues:childUpdates];*/
}

-(void)stopComposingAnswer {
    [self.textView resignFirstResponder];
}



- (void) setIsWritingAnswer:(BOOL)isWritingAnswer  {
    _isWritingAnswer = isWritingAnswer;
    
    [self viewDidLoad];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) setText:(NSString *)text {
    _text = text;
    self.textView.text = text;
    self.textView.userInteractionEnabled = YES;
    self.isWritingAnswer = text.length > 0;
}



- (BOOL)textViewShouldBeginEditing:(UITextView *)textView {
    [self setIsWritingAnswer:YES];
    [self.delegate answerViewWillStartEditing:self];
    
    return YES;
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    NSString *newText = [textView.text stringByReplacingCharactersInRange:range withString:text];
    [self.delegate answerView:self textDidChange:newText];
    return YES;
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
