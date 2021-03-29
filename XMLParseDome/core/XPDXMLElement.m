//
//  XPDXMLElement.m
//  XMLParseDome
//
//  Created by xuezhou.yan on 2021/3/29.
//

#import "XPDXMLElement.h"

@implementation XPDXMLElement
- (instancetype)init
{
    self = [super init];
    if (self) {
        _text=[[NSMutableString alloc]init];
    }
    return self;
}
-(NSMutableArray<XPDXMLElement *> *)childElement{
    if (!_childElement) {
        _childElement = [[NSMutableArray alloc]init];
    }
    return _childElement;
}
-(NSString *)description{
    
    NSDictionary *dic = [self convertToDic];
  
    
    if ([NSJSONSerialization isValidJSONObject:dic]) {
        NSError *error;
        NSData *jsonData=[NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&error];
        if (error) {
            return @"{}";
        }
        if (jsonData) {
            @try {
                NSString *jsonStr = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
                return jsonStr;
            } @catch (NSException *exception) {
                
            }
        }
    }
    
    return @"{}";
    
}
-(NSDictionary *)convertToDic{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    if (self.name) {
        
        dic[self.name]=self.text;
    }
    if (self.attribute&&self.attribute.count>0) {
        [dic addEntriesFromDictionary:self.attribute];
    }
    if (self.childElement&&self.childElement.count>0) {
        NSMutableArray *child=[[NSMutableArray alloc]init];
        for (XPDXMLElement *element in self.childElement) {
            NSDictionary *childDic = [element convertToDic];
            if (element.childElement&&element.childElement.count>0) {
                [child addObject:childDic];
            }else{
                [dic addEntriesFromDictionary:childDic];
            }
            
            
            
        }
//        dic[self.name]=child;
        if (child.count>0) {
            dic[@"child"]=child;
        }
        
        
    }
    return dic;
}
@end
