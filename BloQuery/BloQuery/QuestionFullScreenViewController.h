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
@property (strong, nonatomic) IBOutlet UILabel *labelView;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;

- (instancetype) initWithQuestion:(Question *)question;

@end
