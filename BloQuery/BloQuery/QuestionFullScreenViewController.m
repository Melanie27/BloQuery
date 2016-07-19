//
//  QuestionFullScreenViewController.m
//  BloQuery
//
//  Created by MELANIE MCGANNEY on 7/18/16.
//  Copyright © 2016 Bloc. All rights reserved.
//

#import "QuestionFullScreenViewController.h"
#import "Question.h"

@interface QuestionFullScreenViewController () <UIScrollViewDelegate>
    @property (nonatomic, strong) Question *question;
    @property (nonatomic, strong) UITapGestureRecognizer *tap;

@end

@implementation QuestionFullScreenViewController

- (instancetype) initWithQuestion:(Question *)question {
    self = [super init];
    
    if (self) {
        self.question = question;
        
    }
    
    return self;
}

- (void) viewDidLoad {
    [super viewDidLoad];
    
    
    self.scrollView = [UIScrollView new];
    self.scrollView.delegate = self;
    self.scrollView.backgroundColor = [UIColor grayColor];
    
    
    [self.view addSubview:self.scrollView];
    
   
    self.labelView = [UILabel new];
    self.labelView.text = self.question.questionText;
    [self.scrollView addSubview:self.labelView];
    

   //gesture recognizer
    self.tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapFired:)];
    [self.scrollView addGestureRecognizer:self.tap];

    
}

- (void) viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
    self.scrollView.frame = self.view.bounds;
    
}

- (void)centerScrollView {
    [self.labelView sizeToFit];
    
}

#pragma mark - UIScrollViewDelegate


- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self centerScrollView];
    
}

#pragma mark - Gesture Recognizers

- (void) tapFired:(UITapGestureRecognizer *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end