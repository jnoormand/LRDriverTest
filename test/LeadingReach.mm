//
//  LeadingReach.m
//  St David's Health Care Mk II
//
//  Created by Justin Noormand on 10/28/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "LeadingReach.h"
#include "xmlParser.h"
#import "LRQueue.h"
#import "LREvent.h"

@implementation LeadingReach
@synthesize delegate;
@synthesize queue;

-(id)init {
    receivedData = [[NSMutableData alloc] init];
    connectionLock = false;
    return self;
}

-(void)getAllAssets
{
    state = GETTING_ASSETS;
    NSString *urlString = [NSString stringWithFormat:@"%@",baseURL];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:[NSURL URLWithString:urlString]];
    NSString * bodyString = @"op=getassets&kiosk_id=14512&user=justin&pass=yongqupoke*1";
    NSData *requestBody = [[NSData alloc] initWithData:[bodyString dataUsingEncoding:NSUTF8StringEncoding]];
    [request setHTTPMethod:@"POST"];
    //[request addValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:requestBody];
    
    NSURLConnection *connection = nil;
    if (!connectionLock) {
        NSLog(@"Connection locked.");
        connection = [[NSURLConnection alloc]initWithRequest:request delegate:self startImmediately:YES];
    }else {
        NSLog(@"Could not connect: connection locked.");
    }
    
    if (connection) {
        NSLog(@"Connection made.");
        connectionLock = YES;
        [receivedData setLength:0];
    }
    else {
        NSLog(@"Could not connect: unknown error.");
    }
}

-(void)getAllPersons {
    state = GETTING_PERSONS;
    NSString *urlString = [NSString stringWithFormat:@"%@",baseURL];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:[NSURL URLWithString:urlString]];
    NSString * bodyString = @"op=butts&companyid=14510&user=justin&pass=yongqupoke*1";
    NSData *requestBody = [[NSData alloc] initWithData:[bodyString dataUsingEncoding:NSUTF8StringEncoding]];
    [request setHTTPMethod:@"POST"];
    //[request addValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:requestBody];
    
    NSURLConnection *connection = nil;
    if (!connectionLock) {
        NSLog(@"Connection locked.");
        connection = [[NSURLConnection alloc]initWithRequest:request delegate:self startImmediately:YES];
    }else {
        NSLog(@"Could not connect: connection locked.");
    }
    
    if (connection) {
        NSLog(@"Connection made.");
        connectionLock = YES;
        [receivedData setLength:0];
    }
    else {
        NSLog(@"Could not connect: unknown error.");
    }
}

-(void)getImage:(NSString *)path {
    state = GETTING_IMAGE;
    NSLog(path);
    NSString *urlString = [NSString stringWithFormat:@"%@",path];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:[NSURL URLWithString:urlString]];
    //NSString * bodyString = @"op=getassets&kiosk_id=14512&user=justin&pass=yongqupoke*1";
    //NSData *requestBody = [[NSData alloc] initWithData:[bodyString dataUsingEncoding:NSUTF8StringEncoding]];
    [request setHTTPMethod:@"GET"];
    //[request addValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    //[request setHTTPBody:requestBody];
    
    NSURLConnection *connection = nil;
    if (!connectionLock) {
        NSLog(@"Connection locked.");
        connection = [[NSURLConnection alloc]initWithRequest:request delegate:self startImmediately:YES];
    }else {
        NSLog(@"Could not connect: connection locked.");
    }
    
    if (connection) {
        connectionLock = YES;
        [receivedData setLength:0];
    }
    else {
        NSLog(@"Could not connect: unknown error.");
    }
}

#pragma mark URL Loading System


- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    // This method is called when the server has determined that it
    // has enough information to create the NSURLResponse.
    
    // It can be called multiple times, for example in the case of a
    // redirect, so each time we reset the data.
    
    // receivedData is an instance variable declared elsewhere.
    NSLog(@"Did receive a response.");
    [receivedData setLength:0];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    // Append the new data to receivedData.
    // receivedData is an instance variable declared elsewhere.
    NSLog(@"Did receive data.");
    [receivedData appendData:data];
}

- (void)connection:(NSURLConnection *)connection
  didFailWithError:(NSError *)error
{
    // release the connection, and the data object
    // receivedData is declared as a method instance elsewhere
    
    // inform the user
    NSLog(@"Connection failed! Error - %@ %@",
          [error localizedDescription],
          [[error userInfo] objectForKey:NSURLErrorFailingURLStringErrorKey]);
}


- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSLog(@"Succeeded! Received %u bytes of data",[receivedData length]);
    
    connectionLock = NO;
    //char * output = receivedData;
    NSString * outputstring = [[NSString alloc] initWithData:receivedData encoding:NSUTF8StringEncoding];
    NSLog(outputstring);
    
    
    //XMLNode y = x.getChildNodeByPath("xml/node");
    //y.getChildNodeByPath("xml/node");
    
    //printf(y.getAttributeName());
    printf("\n");
    switch(state) {
        case GETTING_ASSETS:
        {
            XMLNode x = XMLNode::parseString([outputstring UTF8String]);
            XMLNode y = x.getChildNode("xml");
            //XMLNode z = y.getChildNode("node");
            // get all children
            for(int i = 0; i < y.nChildNode() - 1; i++) {
                XMLNode child = y.getChildNode("node", i);
                XMLNode thumb = child.getChildNode("asset_thumbnail");
                XMLNode asset = child.getChildNode("filepath");
                printf(thumb.getText());
                printf("\n");
                LREvent * eventGetThumb = [[LREvent alloc] init];
                eventGetThumb.eventType = GET_IMAGE;
                NSString * passString1 = [[NSString alloc] initWithCString:thumb.getText() encoding:NSUTF8StringEncoding];
                NSLog(passString1);
                eventGetThumb.queryString = passString1;
                [queue addEvent:eventGetThumb];
                LREvent * eventGetImage = [[LREvent alloc] init];
                eventGetImage.eventType = GET_IMAGE;
                NSString * passString2 = [[NSString alloc] initWithCString:asset.getText() encoding:NSUTF8StringEncoding];
                NSLog(passString2);
                eventGetImage.queryString = passString2;
                [queue addEvent:eventGetImage];
            }
            //XMLNode a = z.getChildNode("asset_thumbnail");
            //UIImageView * iview = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithData:
            //[self getImage:a.getText()];
            break;
        }
        case GETTING_PERSONS:
            break;
        case CHECKING_LOGIN:
            break;
        case CREATING_PERSON:
            break;
        case UPDATING_PERSON:
            break;
        case GETTING_IMAGE:
        {
            UIImageView * iview = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithData:receivedData]];
        }
            break;
    }
    /*NSDictionary *gitanaResponse = [[NSDictionary alloc]initWithDictionary:[receivedData objectFromJSONData]];
    
    switch (m_state) {
        case kDriverAuthenticating:
            if ([[gitanaResponse objectForKey:@"ok"] boolValue]) {
                m_gitanaTicket = [[NSString alloc]initWithString:[gitanaResponse objectForKey:@"ticket"]];
                NSLog(@"Received Gitana ticket: %@",m_gitanaTicket);
            }
            else {
                NSLog(@"Failed to authenticate.");
            }     
            
            break;
        case kDriverQueryingRepositories:
            if ([gitanaResponse objectForKey:@"rows"]) {
                for( NSDictionary *eachRow in [gitanaResponse objectForKey:@"rows"] ) {
                    [delegate gitanaReceivedRepository:self guid:[eachRow objectForKey:@"repository"] title:[eachRow objectForKey:@"title"] object:eachRow];
                }
            }
            
            break;
        case kDriverQueryingBranches:
            if ([gitanaResponse objectForKey:@"rows"]) {
                for( NSDictionary *eachRow in [gitanaResponse objectForKey:@"rows"] ) {
                    [delegate gitanaReceivedBranch:self guid:[eachRow objectForKey:@"_doc"] title:[eachRow objectForKey:@"title"]];
                }
            }
            
            break;
        case kDriverQuerying:
            if ([gitanaResponse objectForKey:@"rows"]) {
                for( NSDictionary *eachRow in [gitanaResponse objectForKey:@"rows"] ) {
                    [delegate gitanaReceivedNode:self guid:[eachRow objectForKey:@"_doc"] title:[eachRow objectForKey:@"title"] object:eachRow];
                }
            }
            break;
        case kDriverTraversing:
            if ([gitanaResponse objectForKey:@"nodes"]) {
                for (NSString *eachNode in [gitanaResponse objectForKey:@"nodes"]) {
                    NSDictionary *nodeObj = [[gitanaResponse objectForKey:@"nodes"] objectForKey:eachNode];
                    [delegate gitanaReceivedNode:self guid:[nodeObj objectForKey:@"_doc"] title:[nodeObj objectForKey:@"title"] object:nodeObj];
                }
            }
            break;
        case kDriverCreatingNode:
            if ([[gitanaResponse objectForKey:@"ok"] boolValue]) {
                [delegate gitanaCreatedNode:self guid:[gitanaResponse objectForKey:@"_doc"]];
            }
            break;
        case kDriverAssociating:
            if ([[gitanaResponse objectForKey:@"_is_association"] boolValue]) {
                [delegate gitanaCreatedAssociation:self guid:[gitanaResponse objectForKey:@"_doc"] type:[gitanaResponse objectForKey:@"_type"] object:gitanaResponse];
            }
            break;
        case kDriverQueryingUser:
            if([[gitanaResponse objectForKey:@"_type"] isEqualToString:@"n:person"]) {
                [delegate gitanaReceivedUser:self guid:[gitanaResponse objectForKey:@"_doc"] uid:[gitanaResponse objectForKey:@"principal-id"] userData:gitanaResponse];
            }
            break;
        case kDriverQueryingNode:
            [delegate gitanaReceivedNode:self guid:[gitanaResponse objectForKey:@"_doc"] title:[gitanaResponse objectForKey:@"title"] object:gitanaResponse];
            break;
        case kDriverCreatingUser:
            if ([[gitanaResponse objectForKey:@"ok"] boolValue]){
                [self queryBranchForUser:m_user_id];
            }
            break;
        case kDriverUpdatingNode:
            if ([[gitanaResponse objectForKey:@"ok"] boolValue]) {
                [delegate gitanaUpdatedNode:self guid:[NSString stringWithString:[gitanaResponse objectForKey:@"_doc"]]];
            }
            break;
        default:
            break;
    }
    [delegate finishedGitanaAction:self withState:m_state andObject:gitanaResponse];
    [m_receivedData setLength:0];
    
    if( m_state == kDriverAuthenticating ) {
        [self queryRepositories];
    }*/
    [queue processQueue];
}



@end
