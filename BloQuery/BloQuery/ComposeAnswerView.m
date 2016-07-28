//
//  ComposeAnswerView.m
//  BloQuery
//
//  Created by MELANIE MCGANNEY on 7/26/16.
//  Copyright © 2016 Bloc. All rights reserved.
//

#import "ComposeAnswerView.h"

@interface ComposeAnswerView () <UITextViewDelegate>
//move these to the header file later



@end

@implementation ComposeAnswerView

-(id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if(self) {
        
        
        
        
        
    }
    
    return self;
}


-(void) layoutSubviews {
    [super layoutSubviews];
    
    self.textView.frame = self.bounds;
    
    if(self.isWritingAnswer) {
        self.textView.backgroundColor = [UIColor orangeColor];
        self.button.backgroundColor = [UIColor greenColor];
        
        CGFloat buttonX = CGRectGetWidth(self.bounds) - CGRectGetWidth(self.button.frame) - 20;
        self.button.frame = CGRectMake(buttonX, 10, 80, 20);
    } else {
        self.textView.backgroundColor = [UIColor orangeColor];
        self.button.backgroundColor = [UIColor purpleColor];
        
        self.button.frame = CGRectMake(10, 10, 80, 20);
    }
    
    CGSize buttonSize = self.button.frame.size;
    buttonSize.height += 20;
    buttonSize.width += 20;
    CGFloat blockX = CGRectGetWidth(self.textView.bounds) - buttonSize.width;
    CGRect areaToBlockText = CGRectMake(blockX, 0, buttonSize.width, buttonSize.height);
    UIBezierPath *buttonPath = [UIBezierPath bezierPathWithRect:areaToBlockText];
    
    //exclusion path - text view wont draw text that intersects with this path
    self.textView.textContainer.exclusionPaths = @[buttonPath];
    
}

-(void)answerButtonPressed {
    NSLog(@"answered");
}



//dismiss the keyboard when this method is called
-(void)stopComposingComment {
    [self.textView resignFirstResponder];
}

//animating layout changes
#pragma mark Setters & Getters

- (void) setIsWritingAnswer:(BOOL)isWritingAnswer {
    [self setIsWritingAnswer:isWritingAnswer animated:NO];
}

- (void) setIsWritingAnswer:(BOOL)isWritingAnswer animated:(BOOL)animated {
    _isWritingAnswer = isWritingAnswer;
    
    if (animated) {
        [UIView animateWithDuration:0.2 animations:^{
            [self layoutSubviews];
        }];
    } else {
        [self layoutSubviews];
    }
}

-(void) setText:(NSString *)text {
    _text = text;
    self.textView.text = text;
    self.textView.userInteractionEnabled = YES;
    self.isWritingAnswer = text.length > 0;
}

#pragma mark - Button Target
//when the button is tapped 1) bring up the keyboard 2) send the answer to the API
-(void) answerButtonPressed:(UIButton *) sender {
    if (self.isWritingAnswer) {
        [self.textView resignFirstResponder];
        self.textView.userInteractionEnabled = NO;
        [self.delegate answerViewDidPressAnswerButton:self];
    } else {
        [self setIsWritingAnswer:YES animated:YES];
        [self.textView becomeFirstResponder];
    }
}


#pragma mark UITextViewDelegate
//use UITextViewDelegate protocol to inform the delegate of user actions and update isWritingAnswer

-(BOOL)textViewShouldBeginEditing:(UITextView *)textView {
    [self setIsWritingAnswer:YES animated:YES];
    [self.delegate answerViewWillStartEditing:self];
    return YES;
}

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    NSString *newText = [textView.text stringByReplacingCharactersInRange:range withString:text];
    [self.delegate answerView:self textDidChange:newText];
    return YES;
}

-(BOOL)textViewShouldEndEditing:(UITextView *)textView {
    BOOL hasAnswer = (textView.text.length > 0);
    [self setIsWritingAnswer:hasAnswer animated:YES];
    
    return YES;
}



@end
