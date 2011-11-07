//
//  AssetModel.m
//  test
//
//  Created by Justin Noormand on 11/7/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "AssetModel.h"

@implementation AssetModel

@synthesize assetID;
@synthesize assetTitle;
@synthesize assetFilePath;
@synthesize assetDescription;
@synthesize lastUpdated;
@synthesize assetThumbnail;
@synthesize thumbnailURL;
@synthesize assetType;
@synthesize assetCategory;
@synthesize category;
@synthesize assetData;
@synthesize assetTags;

-(id)init {
    assetID = [[NSString alloc] init];
    assetTitle = [[NSString alloc] init];
    assetFilePath = [[NSString alloc] init];
    assetDescription = [[NSString alloc] init];
    lastUpdated = [[NSString alloc] init];
    assetThumbnail = [[UIImage alloc] init];
    thumbnailURL = [[NSString alloc] init];
    assetType = [[NSString alloc] init];
    assetCategory = [[NSString alloc] init];
    category = BARIATRICS;
    assetTags = [[NSMutableArray alloc] init];
    assetData = [[NSMutableData alloc] init];
    return self;
}

@end
