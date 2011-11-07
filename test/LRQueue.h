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

@interface LRQueue : NSObject {
    NSMutableArray * queue;
    LeadingReach * driver;
    id delegate;
}

@property (nonatomic, retain) NSMutableArray * queue;
@property (nonatomic, retain) LeadingReach * driver;
@property (nonatomic, retain) id delegate;

-(id) initWithDelegate:(id)del;
-(void) addEvent: (LREvent*)event;
-(int) processQueue;

@end
