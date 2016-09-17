//
//  Tokenizer.h
//  BIRx
//
//  Created by Paharia, Vivek on 4/20/16.
//  Copyright © 2016 Paharia, Vivek. All rights reserved.
//

#ifndef Tokenizer_h
#define Tokenizer_h


#endif /* Tokenizer_h */
#import <Foundation/Foundation.h>

#define PATH_TO_STOPLIST @"/Users/vpaharia/workspaceiOS/BIRx/BIRx/stoplist.txt"

@interface Tokeniser : NSObject

@property(nonatomic, strong) NSMutableSet* stopWordsList; // of string

/*!
 * @discussion tokenize string by whitespace and also removes words present in stoplist
 * @param string with words seperated only by whitespaces
 * @return words
 */
-(NSMutableArray*)getTokens:(NSString*) data;

+ (id)sharedTokeniser;

@end
