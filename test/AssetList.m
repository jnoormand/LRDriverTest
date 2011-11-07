//
//  AssetList.m
//  test
//
//  Created by Justin Noormand on 11/7/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "AssetList.h"
#import "AssetModel.h"
@implementation AssetList

-(id)init {
    list = [[NSMutableArray alloc] init];
    return self;
}
-(void)insertAsset:(AssetModel*)assetToInsert {
    [list addObject:assetToInsert];
}
-(AssetModel*)getAssetByTitle:(NSString*)title {
    for(AssetModel * each in list) {
        if([each.assetTitle isEqualToString:title]) {
            return each;
        }
    }
    return nil;
}

@end
