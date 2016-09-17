//
//  Tokenizer.m
//  BIRx
//
//  Created by Paharia, Vivek on 4/20/16.
//  Copyright © 2016 Paharia, Vivek. All rights reserved.
//

#import "Tokenizer.h"

@implementation Tokeniser
static Tokeniser *sharedTokeniser = nil;
static dispatch_once_t onceToken;

+ (id)sharedTokeniser{
    dispatch_once(&onceToken, ^{
        sharedTokeniser = [[self alloc] init];
    });
    return sharedTokeniser;
}

- (id) init
{
    self = [super init];
    //load stop words list
    [self loadStopWords];
    return self;
}

- (NSMutableSet*)stopWordsList{
    _stopWordsList = !_stopWordsList ? [NSMutableSet new] : _stopWordsList ;
    return _stopWordsList;
}

- (void) loadStopWords
{
    // read everything from text
    NSString* fileContents = [NSString stringWithContentsOfFile:PATH_TO_STOPLIST
                                                       encoding:NSUTF8StringEncoding
                                                          error:nil];
    
    // first, separate by new line
    NSArray* allLinedStrings = [fileContents componentsSeparatedByCharactersInSet:[NSCharacterSet newlineCharacterSet]];
    
    for(NSString* line in allLinedStrings){
        [self.stopWordsList addObject:line];
    }
    
}

-(NSMutableArray*)getTokens:(NSString*) data
{
    NSMutableArray* tokens = [NSMutableArray new];
    NSArray* terms = [data componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    for(NSString* term in terms)
    {
        if( ![self.stopWordsList containsObject:term])
        {
            [tokens addObject:term];
        }
        
    }
    
    return tokens;
}
@end