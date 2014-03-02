//
//  Story.m
//  YolarooGrammar
//
//  Created by MGM on 3/1/14.
//  Copyright (c) 2014 Yolaroo. All rights reserved.
//

#import "Story.h"

@interface Story ()
@property (strong, nonatomic) NSArray* theCategoryNameList;
@property (strong, nonatomic) NSArray* thePluralList;
@property (strong, nonatomic) DataModel *DataModel;

- (NSArray*) getWordList: (NSString*)myCategoryName dataModel: (DataModel*)myModel;
- (Animal*) setMyAnimal: (DataModel*)myModel;


@end

@implementation Story

#pragma mark - Story

- (instancetype) initStory: (DataModel*)myModel {
    
    self = [super init];
    NSLog(@"init story: prior");

    if (self)
    {
        self.DataModel = myModel;
        
        self.theCategoryNameList = myModel.theCategoryNameList;
        self.thePluralList = [self getWordList:@"natural plural" dataModel: myModel];
        NSLog(@"init story: self");
        Animal* myAnimal = [self setMyAnimal: myModel];
        self.theStory = [self setMyStory: myAnimal];
    }
    
    return self;
}

#pragma mark - Sentence

-(NSArray*) sentence:(Animal*)myAnimal a: (NSString*)a b: (NSString*)b c:(NSString*)c d:(NSString*)d e:(NSString*)e
{
    NSArray*myarray;
    myarray = [NSArray arrayWithObjects:[self setmyDeterminer:myAnimal theType:a theObject:b],
               b,
               c,
               [self setmyDeterminer:myAnimal theType:d theObject:e],
               e, nil];
    return myarray;
}

-(NSArray*) setMyStory: (Animal*) myAnimal {
    
    NSArray* mySentenceArray01 = [self sentence: myAnimal a: @"null" b:myAnimal.name c:@"is" d:@"indef" e:myAnimal.type];
    NSArray* mySentenceArray02 = [self sentence: myAnimal a: @"poss" b:[myAnimal.bodyParts objectAtIndex:0] c:@"is" d:@"null" e:myAnimal.hairColor];
    NSArray* mySentenceArray03 = [self sentence: myAnimal a: @"null" b:[self convertSubjectPronoun:myAnimal] c:@"lives in" d:@"indef" e:myAnimal.location];
    NSArray* mySentenceArray04 = [self sentence:myAnimal a: @"null" b:myAnimal.name c:@"likes to eat" d:@"null" e:[myAnimal.likes objectAtIndex:[self myRand:[myAnimal.likes count]]]];
    NSArray* mySentenceArray05 = [self sentence:myAnimal a: @"null" b:myAnimal.name c:@"has" d:@"indef" e:[myAnimal.clothes objectAtIndex:[self myRand:[myAnimal.clothes count]]]];
    NSArray*myStory = [NSArray arrayWithObjects:mySentenceArray01,mySentenceArray02,mySentenceArray03,mySentenceArray04,mySentenceArray05, nil];
    
    return myStory;
}

#pragma mark - WordList

- (NSArray*) getWordList: (NSString*)myCategoryName dataModel: (DataModel*)myModel {
    NSArray* myArray;
    WordList* myWordlist = [WordList newList:myCategoryName myModel:myModel];
    myArray = myWordlist.list;
    return myArray;
}

#pragma mark - Animal

- (Animal*) setMyAnimal: (DataModel*)myModel {
    NSLog(@"make model animal");

    NSArray*myAnimals = [self getWordList:@"animal" dataModel:myModel];
    NSArray*myNames;
    NSString*gender = @"";
    if ([self fiftyFifty]){
        myNames= [self getWordList:@"boy's name" dataModel:myModel];
        gender = @"male";
    }else {
        myNames= [self getWordList:@"girl's name" dataModel:myModel];
        gender = @"female";
    }
    NSArray*myLocations = [self getWordList:@"location" dataModel:myModel];
    NSArray*myBodyParts = [self getWordList:@"body part" dataModel:myModel];
    NSArray*myClothes = [self getWordList:@"clothes" dataModel:myModel];
    NSArray* myLikes = [self getWordList:@"food" dataModel:myModel];
    NSArray* myHates = [self getWordList:@"instrument" dataModel:myModel];
    NSArray* myHairColor = [self getWordList:@"hair color" dataModel:myModel];
    
    //NSLog(@"%@",myAnimals);
    Animal *anAnimal = [Animal newAnimal:[myNames objectAtIndex:[self myRand:[myNames count]]] type:[myAnimals objectAtIndex:[self myRand:[myAnimals count]]] gender:gender plural:false location:[myLocations objectAtIndex:[self myRand:[myLocations count]]] hairColor:[myHairColor objectAtIndex:[self myRand:[myHairColor count]]] bodyParts: myBodyParts clothes:myClothes likes:myLikes hates:myHates];
    
    return anAnimal;
}

#pragma mark - Utility

- (BOOL) pluralCheck: (NSString*) theWord{
    if ([self.thePluralList containsObject: theWord]) {
        return true;
    }
    else {
        return false;
    }
}

- (bool) fiftyFifty
{
    if (arc4random() % 2 == 1){
        return false;
    } else {
        return true;
    }
}

-(int)myRand:(int) theMax {
    int myNumber = 0;
    if (theMax > 0){
        myNumber = arc4random() % theMax;
    }
    else {
        NSLog(@"Count Error");
    }
    return myNumber;
}

#pragma mark - Language Modifiers

#pragma mark - Pro Nouns

-(NSString*) convertSubjectPronoun: (Animal*)theAnimal{
    NSString*thePronoun;
    
    if(theAnimal.plural) {
        thePronoun = @"they";
    }
    else {
        if ([theAnimal.gender isEqualToString:@"male"]) {
            thePronoun = @"he";
        }
        else if ([theAnimal.gender isEqualToString:@"female"]) {
            thePronoun = @"she";
        }
        else {
            thePronoun = @"it";
        }
    }
    return thePronoun;
}

-(NSString*) convertObjectPronoun: (Animal*)theAnimal{
    NSString*thePronoun;
    
    if(theAnimal.plural) {
        thePronoun = @"them";
    }
    else {
        if ([theAnimal.gender isEqualToString:@"male"]) {
            thePronoun = @"him";
        }
        else if ([theAnimal.gender isEqualToString:@"female"]) {
            thePronoun = @"her";
        }
        else {
            thePronoun = @"it";
        }
    }
    return thePronoun;
}

#pragma mark - Determiners

-(NSString*) setmyDeterminer: (Animal*)theAnimal theType: (NSString*) theType theObject: (NSString*) myObject{
    
    NSString*theDeterminer = @"";
    if ([theType isEqualToString: @"poss"]) {
        theDeterminer = [self setMyPosDeterminer:theAnimal];
    }
    else if ([theType isEqualToString: @"def"]) {
        theDeterminer = @"the";
    }
    else if ([theType isEqualToString: @"indef"]) {
        if ([self pluralCheck:myObject]) {
            theDeterminer = @"";
        }
        else {
            if ([self hasInitialVowel:myObject]){
                theDeterminer = @"an";
            }
            else {
                theDeterminer = @"a";
            }
        }
    }
    else if ([theType isEqualToString: @"null"]) {
        theDeterminer = @"";
    }
    return theDeterminer;
}

-(bool) hasInitialVowel: (NSString*)object
{
    if ([object hasPrefix:@"a"] || [object hasPrefix:@"A"] || [object hasPrefix:@"e"] || [object hasPrefix:@"E"] || [object hasPrefix:@"i"] || [object hasPrefix:@"I"] || [object hasPrefix:@"o"] || [object hasPrefix:@"O"] || [object hasPrefix:@"u"] || [object hasPrefix:@"U"] || [object hasPrefix:@"y"] || [object hasPrefix:@"Y"]) {
        return true;
    }
    else {
        return false;
    }
}

-(NSString*)setMyPosDeterminer: (Animal*)theAnimal{
    NSString*theDeterminer;
    
    if(theAnimal.plural) {
        theDeterminer = @"their";
    }
    else {
        if ([theAnimal.gender isEqualToString:@"male"]) {
            theDeterminer = @"his";
        }
        else if ([theAnimal.gender isEqualToString:@"female"]) {
            theDeterminer = @"her";
        }
        else {
            theDeterminer = @"its";
        }
    }
    return theDeterminer;
}


@end
