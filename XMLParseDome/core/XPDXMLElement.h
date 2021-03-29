//
//  XPDXMLElement.h
//  XMLParseDome
//
//  Created by xuezhou.yan on 2021/3/29.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface XPDXMLElement : NSObject
// 元素名称
@property (nonatomic, strong) NSString *name;
//元素节点文本
@property (nonatomic, strong) NSMutableString *text;

@property (nonatomic, strong) NSDictionary *attribute;

@property (nonatomic, strong) XPDXMLElement *parent;

@property (nonatomic, strong) NSMutableArray<XPDXMLElement *> *childElement;

-(NSDictionary *)convertToDic;
@end

NS_ASSUME_NONNULL_END
