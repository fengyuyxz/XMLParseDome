//
//  XMLParseManager.h
//  XMLParseDome
//
//  Created by xuezhou.yan on 2021/3/29.
//

#import <Foundation/Foundation.h>

#import "XPDXMLElement.h"

@interface XMLParseManager : NSObject
typedef void(^ParseXMLCompletion)(BOOL SUC,XPDXMLElement *data,NSError *error);
-(void)parseXMLWithURL:(NSURL *)url completion:(ParseXMLCompletion)block;
@end


