//
//  LRQueue.m
//  test
//
//  Created by Justin Noormand on 11/1/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "LRQueue.h"
#import "LREvent.h"
#import "LeadingReach.h"

@implementation LRQueue
@synthesize driver;
@synthesize queue;
@synthesize delegate;

-(id) initWithDelegate:(id)del {
    delegate = del;
    driver = [[LeadingReach alloc] init];
    driver.delegate = delegate;
    driver.queue = self;
    queue = [[NSMutableArray alloc] init];
    return self;
}
-(void) addEvent: (LREvent*)event {
    [queue addObject:event];
}
-(int) processQueue {
    if([queue count] == 0) return 0;
    LREvent * currentEvent = [queue objectAtIndex:0];
    switch(currentEvent.eventType) {
        case GET_IMAGE:
            [driver getImage:currentEvent.queryString];
            break;
        case CHECK_LOGIN:
            [driver loginUser:(NSMutableDictionary*)currentEvent.data];
            break;
        case CREATE_PERSON:
            [driver createPerson:(NSMutableDictionary *)currentEvent.data];
            break;
        case GET_ASSETS:
            [driver getAllAssets];
            break;
        case GET_PERSONS:
            [driver getAllPersons];
            break;
        case UPDATE_PERSON:
            [driver updatePerson:(NSMutableDictionary *)currentEvent.data];
            break;
    }
    [queue removeObjectAtIndex:0];
    
    return [queue count];
}

@end
