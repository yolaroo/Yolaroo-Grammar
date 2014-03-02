//
//  SimpleSentences.m
//  YolarooGrammar
//
//  Created by MGM on 2/25/14.
//  Copyright (c) 2014 Yolaroo. All rights reserved.
//

#import "SimpleSentences.h"

@interface SimpleSentences ()
{
    int sentenceCount;
    bool isOkToPress;
}
@end

@implementation SimpleSentences

#pragma mark - Button Press

- (IBAction)myButton:(UIButton *)sender {
    if (isOkToPress){
        [self updateUI];
    }
}

-(void) updateUI {
    if ([self.theFinalStoryArray count]) {
        if (sentenceCount < [self.theFinalStoryArray count]) {
            NSString*mystring = [Sentence newSentencefromArray:[self.theFinalStoryArray objectAtIndex:sentenceCount]].completeSentence;
            self.myLabel.text = mystring;
            sentenceCount++;
        }
        else {
            sentenceCount = 0;
            NSLog(@"Reset");
            [self makeNewStoryData];
        }
    }
}

-(void) makeNewStoryData {
    self.myLabel.text = @"The End";
    self.myStory = [self setMyStory];
    self.theFinalStoryArray = self.myStory.theStory;
}

-(void) buttonPressDelay {
    isOkToPress = true;
}

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    isOkToPress = false;
    [self performSelector:@selector(buttonPressDelay) withObject:nil afterDelay:1];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

@end



//NSArray*myClassArray = [self wordClassCheck:@"tomato"];
//NSLog(@"type: %@", [myClassArray objectAtIndex:0]);
//bool mybool = [self pluralCheck:@"pajamas"];
//NSArray*myClassArray = [self wordTypeCheck:@"tomato"];
//NSArray*myClassArray = [self getMyClassData];
//NSArray*myClassArray = [self getMyClassMetaData];
//NSArray*myWordArray = [self loadMyWordsFromClass:@"Animals"];
//NSLog(@"%@",myClassArray);

/*
 NSArray* myBodyPartsArray = [NSArray arrayWithObjects:@"hair",@"eyes",nil];
 NSArray* myClothesArray = [NSArray arrayWithObjects:@"glasses",@"shoes",nil];
 NSArray* myLikes = [NSArray arrayWithObjects:@"pizza",@"to dance",nil];
 NSArray* myHates = [NSArray arrayWithObjects:@"to wash dishes",@"shopping",nil];
 Animal *anAnimal = [Animal newAnimal:@"Bryan" type:@"cow" gender:@"male" plural:false location:@"supermarket" hairColor:@"black" bodyParts: myBodyPartsArray clothes:myClothesArray likes:myLikes hates:myHates];
 */