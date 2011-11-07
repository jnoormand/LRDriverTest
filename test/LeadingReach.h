//
//  LeadingReach.h
//  St David's Health Care Mk II
//
//  Created by Justin Noormand on 10/28/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#define baseURL @"https://leadingreach.com/main.php"
@class LRQueue;
@class AssetList;
typedef enum LRState {GETTING_ASSETS,GETTING_PERSONS,UPDATING_PERSON,CHECKING_LOGIN,CREATING_PERSON,GETTING_ASSET, GETTING_THUMBNAIL} LRState;

@interface LeadingReach : NSObject {
    LRState state;
    id delegate;
    LRQueue * queue;
    NSString *userId;
    NSString *userPassword;
    
    // URL Loading variables;
    int statusCode;
    bool connectionLock;
    AssetList * assetList;
    NSMutableData * receivedData;
    NSString * currentString;
    
}
@property (nonatomic,retain) id delegate;
@property (nonatomic,retain) LRQueue * queue;

-(id) init;
-(BOOL)loginUser:(NSMutableDictionary *)data;
-(void)createPerson:(NSMutableDictionary *)data;
-(void)getAllPersons;
-(void)updatePerson:(NSMutableDictionary *)data;
-(void)getAllAssets;
-(void)getImage:(NSString *)path withTitle:(NSString*)title;
-(void)getThumbnail:(NSString *)path withTitle:(NSString*)title;

@end
