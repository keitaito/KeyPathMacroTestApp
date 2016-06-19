//
//  ViewController.m
//  KeyPathMacroTestApp
//
//  Created by Keita Ito on 6/18/16.
//  Copyright © 2016 Keita Ito. All rights reserved.
//

#import "ViewController.h"
#import "Model.h"

#define keyPath(base, path) ({ __typeof__(base.path) _ __attribute__((unused)); @#path; })

@interface ViewController ()

@property (nonatomic, strong) Model *model;
@property (nonatomic, strong) UILabel *label;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
        // Create a model object.
    self.model = [[Model alloc] init];
    
    // Create a label.
    self.label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 20)];
    self.label.center = self.view.center;
    self.label.text = @"label";
    [self.view addSubview:self.label];
    
    // Set up KVO.
    [self.model addObserver:self forKeyPath:keyPath(self.model, name) options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [NSTimer scheduledTimerWithTimeInterval:3.0 target:self selector:@selector(changeValue) userInfo:nil repeats:YES];
}

- (void)changeValue {
    static BOOL flag = NO;
    
    if (!flag) {
        flag = YES;
        self.model.name = @"Swift";
    } else {
        flag = NO;
        self.model.name = @"Objective-C";
    }
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:keyPath(self.model, name)]) {
        NSString *newValueString = change[NSKeyValueChangeNewKey];
        NSString *oldValueString = change[NSKeyValueChangeOldKey];
        NSLog(@"newValue: %@, oldValue:%@", newValueString, oldValueString);
        self.label.text = newValueString;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [self removeObserver:self.model forKeyPath:keyPath(self.model, name)];
}

@end
