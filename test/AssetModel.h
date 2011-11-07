//
//  AssetModel.h
//  test
//
//  Created by Justin Noormand on 11/7/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum AssetCategory {BARIATRICS,} AssetCategory;

@interface AssetModel : NSObject {
    NSString * assetID;
    NSString * assetTitle;
    NSString * assetFilePath;
    NSString * assetDescription;
    NSString * lastUpdated;
    UIImage * assetThumbnail;
    NSMutableData * assetData;
    NSString * thumbnailURL;
    NSString * assetType;
    NSString * assetCategory;
    AssetCategory category;
    NSMutableArray * assetTags;
    
}

@property (nonatomic,retain) NSString * assetID;
@property (nonatomic,retain) NSString * assetTitle;
@property (nonatomic,retain) NSString * assetFilePath;
@property (nonatomic,retain) NSString * assetDescription;
@property (nonatomic,retain) NSString * lastUpdated;
@property (nonatomic,retain) UIImage * assetThumbnail;
@property (nonatomic,retain) NSString * thumbnailURL;
@property (nonatomic,retain) NSString * assetType;
@property (nonatomic,retain) NSString * assetCategory;
@property (assign) AssetCategory category;
@property (nonatomic,retain) NSMutableArray * assetTags;
@property (nonatomic,retain) NSMutableData * assetData;

-(id)init;

@end
