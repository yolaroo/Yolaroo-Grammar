//
//  ViewController.m
//  YolarooGrammar
//
//  Created by MGM on 2/25/14.
//  Copyright (c) 2014 Yolaroo. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController

#pragma mark - Data Load on View Load

- (void) dataLoader {
    self.DataModel = [self setMyDataModel];
    
    self.myStory = [self setMyStory];
    self.theFinalStoryArray = self.myStory.theStory;
}

- (NSArray*) getWordList: (NSString*)myCategoryName {
    NSArray* myArray;
    WordList* myWordlist = [WordList newList:myCategoryName myModel:self.DataModel];
    myArray = myWordlist.list;
    return myArray;
}

- (DataModel*) setMyDataModel {
    DataModel * myDataModel = [DataModel newDataModel];
    NSLog(@"dataSet");
    return myDataModel;
}

- (Story*) setMyStory {
    Story* myStory = [[Story alloc] initStory:self.DataModel];
    NSLog(@"story set");
    return myStory;
}

#pragma Mark - Life Cycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self performSelector:@selector(test) withObject:nil afterDelay:2];
    [self performSelectorInBackground:@selector(dataLoader) withObject:nil];

}

-(void) test {
    //NSString* mystring = [self.theFinalStoryArray objectAtIndex:0];
    //NSLog(@"!!!!! %@",mystring);
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = false;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

- (void)didMoveToParentViewController:(UIViewController *)parent
{
    if (![parent isEqual:self.parentViewController]) {
        [self myCleaner];
    }
}

- (void) myCleaner {
    UIViewController *vc = self;
    while ([vc presentingViewController] != NULL) {
        vc = [vc presentingViewController];
    }
    [self cleanTheSubview];
    
    [vc removeFromParentViewController];
    
    [vc dismissViewControllerAnimated:NO completion:nil];
}

- (void) cleanTheSubview
{
    for(UIView *subview in [self.view subviews]) {
        [subview removeFromSuperview];
    }
}


@end
