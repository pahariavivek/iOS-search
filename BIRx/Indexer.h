//
//  Indexer.h
//  BIRx
//
//  Created by Paharia, Vivek on 4/20/16.
//  Copyright © 2016 Paharia, Vivek. All rights reserved.
//

#ifndef Indexer_h
#define Indexer_h


#endif /* Indexer_h */
#import <Foundation/Foundation.h>

@interface Indexer : NSObject

@property(nonatomic, strong) NSMutableDictionary* invertedIndexes;// of <String, Set<Integer>>
@property(nonatomic, strong) NSMutableArray* docIdDataMapping; // of <String>

/*!
 * @discussion returns document from its id
 * @param doc id
 * @return actual document
 */
- (NSString*) getDocFromId:(NSUInteger)docId;

/*!
 * @discussion returns document id of the all doc which contains the term
 * @param term to look
 * @return doc ids
 */
- (NSMutableSet*)getDocsForTerm:(NSString*)term;

/*!
 * @discussion this builds search index or BIR index
 * @param document id in which term is present
 */
- (void) addInvIndex:(NSString*)term docId:(NSUInteger)docId;

/*!
 * @discussion assign id to a doc
 * @param complete document
 * @return doc id
 */
- (NSUInteger) addDoc:(NSString*) data;

@end