//
//  main.m
//  BIRx
//
//  Created by Paharia, Vivek on 4/20/16.
//  Copyright © 2016 Paharia, Vivek. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Indexer.h"
#import "Tokenizer.h"

#define PATH_TO_DOCUMENTS_FOR_SEARCH @"/Users/vpaharia/workspaceiOS/BIRx/BIRx/documents.txt"

@interface Search : NSObject

@property(nonatomic, strong) Indexer* indexerInstance;

@end

@implementation Search

int main(int argc, char * argv[])
{
    Search* solr = [Search new];

    NSError* error;
    NSString* fileContents = [NSString stringWithContentsOfFile:PATH_TO_DOCUMENTS_FOR_SEARCH
                                                       encoding:NSUTF8StringEncoding
                                                          error:&error];

    if(error) {
        printf("cannot find document.txt\n");
        return 1;
    }
    // first, separate by new line
    NSArray* allLinedStrings = [fileContents componentsSeparatedByCharactersInSet:[NSCharacterSet newlineCharacterSet]];
    
    for(NSString* line in allLinedStrings) {

        [solr indexDoc:[line lowercaseString]];
    }

    printf( "enter query string \n" );
    char str[1000];
    while(true) {

        // take query as input
        fgets (str, 999, stdin);

        for(int i=0;i<1000;i++) {
            if(str[i] =='\n')
            str[i] = '\0';
        }

        NSString* query = [NSString stringWithUTF8String:str];
        query = [query stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        
        NSMutableSet* docs = [solr getDocs:[query lowercaseString]];
        int i = 1;
        for(NSString* s in docs) {
            printf("%d %s\n",i,[s UTF8String]);
            i++;
        }

        if([docs count] == 0)
            printf("No results found!!\n");

    }
}

-(Indexer*) indexerInstance
{
    _indexerInstance = !_indexerInstance ? [Indexer new] : _indexerInstance;
    return _indexerInstance;
}

- (void) indexDoc:(NSString*) data
{
    // get tokens
    NSMutableArray* indexTokens = [[Tokeniser sharedTokeniser] getTokens:data];
    
    NSUInteger docId = [self.indexerInstance addDoc:data];
    
    for(NSString* token in indexTokens)
        [self.indexerInstance addInvIndex:token docId:docId];
    
}

- (NSMutableSet*) getDocs:(NSString*) query
{
    NSArray* queryTerms = [query componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];

    //take instersection of all the documents id in which the query term is present
    NSMutableSet* docIds = [self.indexerInstance getDocsForTerm:[queryTerms objectAtIndex:0]];
    for(NSString* term in queryTerms) {
        [docIds intersectSet:[self.indexerInstance getDocsForTerm:term]];
    }
    
    // get document contents from document id
    NSMutableSet* docs = [NSMutableSet new];
    for(NSNumber* num in docIds) {
        [docs addObject:[self.indexerInstance getDocFromId:[num intValue]]];
    }
    return docs;
}

@end