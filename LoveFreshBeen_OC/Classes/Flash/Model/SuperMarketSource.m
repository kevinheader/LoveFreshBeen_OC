//
//  SuperMarketSource.m
//  LoveFreshBeen_OC
//
//  Created by 江科 on 16/3/14.
//  Copyright © 2016年 江科. All rights reserved.
//

#import "SuperMarketSource.h"
#import "Goods.h"

@implementation SuperMarketSource
+ (void)loadSupermarketData:(CompleteBlock)complete {
    NSString *path = [[NSBundle mainBundle] pathForResource:@"supermarket" ofType:nil];
    NSData *data = [NSData dataWithContentsOfFile:path];
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    SuperMarketSource *source = [SuperMarketSource mj_objectWithKeyValues:json];
    SuperMarketData *superMarketData = source.data;
    for (NSInteger i = 0; i < superMarketData.categories.count; i++) {
        ProductCategory *catgeory = superMarketData.categories[i];
        NSArray *productsArr = superMarketData.products[catgeory.id];
        catgeory.products = [Goods mj_objectArrayWithKeyValuesArray:productsArr];
    }
    complete(superMarketData,nil);
}
@end


@implementation SuperMarketData

+ (NSDictionary *)mj_objectClassInArray {
    return @{@"categories":NSStringFromClass([ProductCategory class])};
}

@end


@implementation ProductCategory


+ (NSDictionary *)mj_objectClassInArray {
    return @{@"products":NSStringFromClass([Goods class])};
}
@end
