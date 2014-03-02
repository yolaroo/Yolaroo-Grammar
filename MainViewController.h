//
//  ViewController.h
//  YolarooGrammar
//
//  Created by MGM on 2/25/14.
//  Copyright (c) 2014 Yolaroo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Animal.h"
#import "Sentence.h"
#import "MetaSentence.h"
#import "DataModel.h"
#import "WordList.h"
#import "LanguageData.h"
#import "Story.h"

@class Animal;
@class Sentence;
@class MetaSentence;
@class DataModel;
@class WordList;
@class Story;

@interface MainViewController : UIViewController

@property (strong, nonatomic) NSArray* theStoryArray;

@property (strong, nonatomic) Animal * myAnimal;
@property (strong, nonatomic) Sentence * mySentence;
@property (strong, nonatomic) DataModel * DataModel;
@property (strong, nonatomic) WordList * myWordList;
@property (strong, nonatomic) Story * myStory;

@property (strong, nonatomic) NSArray* theCategoryNameList;
@property (strong, nonatomic) NSArray* thePluralList;

@property (strong, nonatomic) NSArray* theFinalStoryArray;


- (Story*) setMyStory;
- (DataModel*)setMyDataModel;


//- (Animal*) setMyAnimal;
//- (int)myRand:(int) theMax;

//-(NSString*) convertSubjectPronoun: (Animal*)theAnimal;
//-(NSString*) convertObjectPronoun: (Animal*)theAnimal;

//-(NSArray*) sentence:(Animal*)myAnimal a: (NSString*)a b: (NSString*)b c:(NSString*)c d:(NSString*)d e:(NSString*)e;
//-(bool) fiftyFifty;




@end
