//
//  ComposeAnswerView.h
//  BloQuery
//
//  Created by MELANIE MCGANNEY on 7/26/16.
//  Copyright © 2016 Bloc. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ComposeAnswerView;

@protocol ComposeAnswerViewDelegate <NSObject>

- (void) answerViewDidPressAnswerButton:(ComposeAnswerView *)sender;

- (void) answerView:(ComposeAnswerView *)sender textDidChange:(NSString *)text;

- (void) answerViewWillStartEditing:(ComposeAnswerView *)sender;

@end

@interface ComposeAnswerView : UIView

@property (nonatomic, weak) NSObject <ComposeAnswerViewDelegate> *delegate;

@property (nonatomic, assign) BOOL isWritingAnswer;

@property (nonatomic, strong) IBOutlet NSString *text;



@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (nonatomic, strong) IBOutlet UIButton *button;



//-(void) stopComposingAnswer;

@end
