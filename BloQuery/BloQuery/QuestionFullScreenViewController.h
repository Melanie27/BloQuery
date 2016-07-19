//
//  QuestionFullScreenViewController.h
//  BloQuery
//
//  Created by MELANIE MCGANNEY on 7/18/16.
//  Copyright © 2016 Bloc. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Question;

@interface QuestionFullScreenViewController : UIViewController

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UILabel *labelView;

- (instancetype) initWithQuestion:(Question *)question;

- (void) centerScrollView;

@end
