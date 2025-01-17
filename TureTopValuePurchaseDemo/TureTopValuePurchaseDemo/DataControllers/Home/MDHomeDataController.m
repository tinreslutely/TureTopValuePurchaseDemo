//
//  MDHomeDataController.m
//  TureTopValuePurchaseDemo
//  首页数据控制器
//  Created by 李晓毅 on 16/1/14.
//  Copyright © 2016年 铭道超值购. All rights reserved.
//

#import "MDHomeDataController.h"


@implementation MDHomeDataController

#pragma mark public methods
/*!
 *  获取首页初始模块布局数据
 *
 *  @param type       类型
 *  @param completion 完成回调
 */
-(void)requestDataWithType:(NSString*)type completion:(void(^)(BOOL state, NSString *msg, NSArray<MDHomeRenovateChannelModel*> *list))completion{
    [MDHttpManager GET:APICONFIG.homeApiURLString parameters:@{@"type":type} sucessBlock:^(id  _Nullable responseObject) {
        MDHomeRenovateModel *renovateModel = [[MDHomeRenovateModel alloc] init];
        NSDictionary *dic = [responseObject isKindOfClass:[NSDictionary class]] ? responseObject : [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
        if(dic == nil || ![[dic objectForKey:@"state"] isEqualToString:@"200"]){
            completion(NO,[dic objectForKey:@"result"],nil);
            return;
        }
        renovateModel.stateCode = [dic objectForKey:@"state"];
        renovateModel.state = YES;
        renovateModel.list = [MDHomeRenovateChannelModel mj_objectArrayWithKeyValuesArray:[[dic objectForKey:@"result"] objectForKey:@"list"]];
        for (MDHomeRenovateChannelModel *channelModel in renovateModel.list) {
            channelModel.channelColumnDetails = [MDHomeRenovateChannelDetailModel mj_objectArrayWithKeyValuesArray:channelModel.channelColumnDetails];
        }
        [renovateModel.list sortUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
            return [[NSNumber numberWithInt:[(MDHomeRenovateChannelModel*)obj1 columnType]] compare:[NSNumber numberWithInt:[(MDHomeRenovateChannelModel*)obj2 columnType]]];
        }];
        completion(renovateModel.state,renovateModel.message,renovateModel.list);
    } failureBlock:^(NSError * _Nonnull error) {
        completion(NO,[NSString stringWithFormat:@"%@",error],nil);
    }];
}

/*!
 *  获取首页你喜欢商品数据
 *
 *  @param type       类型（超值购/快乐购）
 *  @param pageIndex  当前页
 *  @param pageSize   每页页数
 *  @param completion 完成回调
 */
-(void)requestDataWithType:(NSString*)type pageIndex:(int)pageIndex pageSize:(int)pageSize  completion:(void(^)(BOOL state, NSString *msg, NSArray<MDHomeLikeProductModel*> *list))completion{
    [MDHttpManager GET:APICONFIG.homeLikeProductApiURLString parameters:@{@"type":type,@"pageSize":[NSString stringWithFormat:@"%d",pageSize],@"pageIndex":[NSString stringWithFormat:@"%d",pageIndex]} sucessBlock:^(id  _Nullable responseObject) {
        MDHomeLikeProductsModel *productsModel = [[MDHomeLikeProductsModel alloc] init];
        NSDictionary *dic = [responseObject isKindOfClass:[NSDictionary class]] ? responseObject : [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
        if(dic == nil || ![[dic objectForKey:@"state"] isEqualToString:@"200"]){
            completion(NO,[dic objectForKey:@"result"],nil);
            return;
        }
        productsModel.stateCode = [dic objectForKey:@"state"];
        productsModel.state = YES;
        productsModel.list = [[NSMutableArray alloc] init];
        NSArray *array = [dic objectForKey:@"result"];
        MDHomeLikeProductModel *model;
        for (NSDictionary *item in array) {
            model = [[MDHomeLikeProductModel alloc] init];
            model.productId = [[item objectForKey:@"id"] intValue];
            model.imageURL = [[[item objectForKey:@"mainPic"] objectForKey:@"shopPic"] objectForKey:@"picAddr"];
            model.sellPirce = [[item objectForKey:@"salesPrice"] doubleValue];
            model.shopId = [[item objectForKey:@"shopId"] intValue];
            model.title = [item objectForKey:@"productName"];
            [productsModel.list addObject:model];
        }
        completion(productsModel.state,nil,productsModel.list);
        
    } failureBlock:^(NSError * _Nonnull error) {
        completion(NO,[NSString stringWithFormat:@"%@",error],nil);
    }];
}

/*!
 *  获取消息总条数
 *
 *  @param userId     用户id
 *  @param completion 回调函数
 */
-(void)requestTotalDataWithUserId:(NSString*)userId completion:(void(^)(BOOL state, NSString *msg, int total))completion{
    [MDHttpManager GET:APICONFIG.totalMessageApiURLString parameters:@{@"userId":userId} sucessBlock:^(id  _Nullable responseObject) {
        NSDictionary *dic = [responseObject isKindOfClass:[NSDictionary class]] ? responseObject : [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
        NSString *stateCode = [dic objectForKey:@"state"];
        if(dic == nil || ![stateCode isEqualToString:@"200"]){
            completion(NO,[dic objectForKey:@"result"],0);
            return;
        }
        completion(YES,nil,[[[dic objectForKey:@"result"] objectForKey:@"total"] intValue]);
    } failureBlock:^(NSError * _Nonnull error) {
        completion(NO,[NSString stringWithFormat:@"%@",error],0);
    }];
}

-(void)requestNoReadDataWithUserId:(NSString*)userId completion:(void(^)(BOOL state, NSString *msg, int total))completion{
    [MDHttpManager GET:APICONFIG.noReadNumberMessageApiURLString parameters:@{@"userId":userId} sucessBlock:^(id  _Nullable responseObject) {
        
    } failureBlock:^(NSError * _Nonnull error) {
        
    }];
}
@end
