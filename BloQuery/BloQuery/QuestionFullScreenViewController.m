//
//  QuestionFullScreenViewController.m
//  BloQuery
//
//  Created by MELANIE MCGANNEY on 7/15/16.
//  Copyright © 2016 Bloc. All rights reserved.
//

#import "QuestionFullScreenViewController.h"
#import "Question.h"


@interface QuestionFullScreenViewController ()

@property (nonatomic, strong) Question *question;

@end

@implementation QuestionFullScreenViewController

-(instancetype) initWithQuestion:(Question *)question {
    self = [super init];
    
    if(self) {
        self.question = question;
    }
    
    return self;
}

-(void) viewDidLoad {
    [super viewDidLoad];
}

-(void) viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
}

@end
