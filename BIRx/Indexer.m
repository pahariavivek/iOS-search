//
//  Indexer.m
//  BIRx
//
//  Created by Paharia, Vivek on 4/20/16.
//  Copyright © 2016 Paharia, Vivek. All rights reserved.
//

#import "Indexer.h"

@implementation Indexer

- (NSMutableArray*)docIdDataMapping{
    _docIdDataMapping = !_docIdDataMapping ? [NSMutableArray new] : _docIdDataMapping ;
    return _docIdDataMapping;
}

- (NSMutableDictionary*)invertedIndexes{
    _invertedIndexes = !_invertedIndexes ? [NSMutableDictionary new] : _invertedIndexes ;
    return _invertedIndexes;
}

- (NSMutableDictionary *) getInvertedIndexes{
    return self.invertedIndexes;
}

- (NSString*) getDocFromId:(NSUInteger)docId
{
    return [self.docIdDataMapping objectAtIndex:docId];
}

- (NSMutableSet*)getDocsForTerm:(NSString*)term
{
//    NSMutableSet* set = [self particalMatch:term];
//        return set;
    if([self.invertedIndexes objectForKey:term])
        return [self.invertedIndexes objectForKey:term];
    else
        return [NSMutableSet new];
}

//- (NSMutableSet*) particalMatch:(NSString*) term
//{
//    NSMutableSet* returnSet = [NSMutableSet new];
//    for(NSString* key in [self.invertedIndexes allKeys]){
//        if([key hasPrefix:term]){
//            [returnSet unionSet:[self.invertedIndexes objectForKey:key]];
//        }
//    }
//    return returnSet;
//}

- (void) addInvIndex:(NSString*)term docId:(NSUInteger)docId
{
    if([self.invertedIndexes objectForKey:term])
    {
        NSMutableSet* list = [self.invertedIndexes objectForKey:term];
        [list addObject:[NSNumber numberWithUnsignedInteger:docId]];
        [self.invertedIndexes setObject:list forKey:term];
    }
    else
    {
        NSMutableSet* list = [NSMutableSet new];
        [list addObject:[NSNumber numberWithUnsignedInteger:docId]];
        [self.invertedIndexes setObject:list forKey:term];
    }
    
}

- (NSUInteger) addDoc:(NSString*) data
{
    [self.docIdDataMapping addObject:data];
    return [self.docIdDataMapping count] - 1;
}

@end