//
//  LRQueue.h
//  test
//
//  Created by Justin Noormand on 11/1/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
@class LeadingReach;
@class LREvent;
@class LRQueue;

@interface LRQueue : NSObject {
    NSMutableArray * queue;
    LeadingReach * driver;
    id delegate;
}

@property (nonatomic, retain) NSMutableArray * queue;
@property (nonatomic, retain) LeadingReach * driver;
@property (nonatomic, retain) id delegate;

-(id) initWithDriver:(id)initDriver;
-(void) addEvent: (LREvent*)event;
-(int) processQueue;

@end
