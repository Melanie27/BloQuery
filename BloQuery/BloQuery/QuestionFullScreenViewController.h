//
//  QuestionFullScreenViewController.h
//  BloQuery
//
//  Created by MELANIE MCGANNEY on 7/15/16.
//  Copyright © 2016 Bloc. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Question;

@interface QuestionFullScreenViewController : UIViewController


@property (nonatomic, strong) UITextView *textView;

-(instancetype) initWithQuestion:(Question *)question;



@end
