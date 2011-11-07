//
//  AssetList.h
//  test
//
//  Created by Justin Noormand on 11/7/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
@class AssetModel;

@interface AssetList : NSObject {
    NSMutableArray * list;
}

-(id)init;
-(void)insertAsset:(AssetModel*)assetToInsert;
-(AssetModel*)getAssetByTitle:(NSString*)title;

@end
