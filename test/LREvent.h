//
//  LREvent.h
//  test
//
//  Created by Justin Noormand on 11/1/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
@class FamilyModel;
@class PatientModel;
typedef enum EventType {GET_ASSETS,GET_PERSONS,UPDATE_PERSON,CHECK_LOGIN,CREATE_PERSON,GET_ASSET,GET_THUMBNAIL} EventType;
typedef enum PersonType {Patient, Family,} PersonType;
typedef enum AssociationType {Participation, SessionEnding,} AssociationType;

@interface LREvent : NSObject {
    EventType eventType;
    PersonType personType;
    NSString * queryString;
    id data;
    NSString * title;
}

@property (nonatomic, retain) NSString * title;
@property (assign) EventType eventType;
@property (assign) PersonType personType;
@property (nonatomic, retain) NSString * queryString;
@property (nonatomic, retain) id data;
    
@end

