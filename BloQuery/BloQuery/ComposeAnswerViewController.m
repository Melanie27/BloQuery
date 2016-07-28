//
//  ComposeAnswerViewController.m
//  
//
//  Created by MELANIE MCGANNEY on 7/27/16.
//
//

#import "ComposeAnswerViewController.h"

@interface ComposeAnswerViewController () <UITextViewDelegate>

@end

@implementation ComposeAnswerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.textView.delegate = self;
    
    //
    // Do any additional setup after loading the view.
    
    if(self.isWritingAnswer) {
        self.textView.backgroundColor = [UIColor whiteColor];
        
    } else {
        [self.textView becomeFirstResponder];
        self.textView.backgroundColor = [UIColor purpleColor];
        //
       
    }
}

//dismiss the keyboard when this method is called
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


@end
