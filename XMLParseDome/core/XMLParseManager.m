//
//  XMLParseManager.m
//  XMLParseDome
//
//  Created by xuezhou.yan on 2021/3/29.
//

#import "XMLParseManager.h"

#define dispatch_main_safe_async(block) if ([NSThread isMainThread]) {\
block();\
}else{\
dispatch_async(dispatch_get_main_queue(), ^{\
    block();\
});\
}

@interface XMLParseManager()<NSXMLParserDelegate>
@property (nonatomic, strong) NSXMLParser *parser;
@property(nonatomic,copy)ParseXMLCompletion block;

@property (nonatomic, strong) XPDXMLElement *rootElement;
@property (nonatomic, strong) XPDXMLElement *currentElement;

@end
@implementation XMLParseManager
-(void)parseXMLWithURL:(NSURL *)url completion:(ParseXMLCompletion)block{
    if (url) {
        
        self.block=block;
       
        __weak typeof(self) weakSelf = self;
        NSInputStream *fileInput=[[NSInputStream alloc]initWithURL:url];
        
        _parser = [[NSXMLParser alloc]initWithStream:fileInput];
        _parser.delegate = self;
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT,0), ^{
            __strong typeof(weakSelf) strongSelf = weakSelf;
            [strongSelf.parser parse];
            if (weakSelf.parser.parserError) {
                dispatch_main_safe_async(^{
                    
                    if (block) {
                        block(NO,nil,strongSelf.parser.parserError);
                    }
                });
            }
        });
    }
}
-(void)parserDidStartDocument:(NSXMLParser *)parser{
    self.rootElement=nil;
    self.currentElement = nil;
}
-(void)parserDidEndDocument:(NSXMLParser *)parser{
    __weak typeof(self) weakSelf = self;
    if (self&&self.block) {
       
        dispatch_main_safe_async(^{
            __strong typeof(weakSelf) strongSelf = weakSelf;
            strongSelf.block(YES, strongSelf.rootElement, nil);
        });
    }
}
-(void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary<NSString *,NSString *> *)attributeDict{

    if (!self.rootElement) {
        self.rootElement = [[XPDXMLElement alloc]init];
        self.currentElement = self.rootElement;
    }else{
        XPDXMLElement *element = [[XPDXMLElement alloc]init];
        element.parent = self.currentElement;
        [self.currentElement.childElement addObject:element];
        element.name = elementName;
        self.currentElement = element;
    }
    self.currentElement.name = elementName;
    self.currentElement.attribute = attributeDict;
}

/* 当解析器找到开始标记和结束标记之间的字符时，调用这个方法解析当前节点的所有字符 */
- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    [self.currentElement.text appendString:string];
}

-(void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName{
    self.currentElement = self.currentElement.parent;
    
}
- (void)parser:(NSXMLParser *)parser validationErrorOccurred:(NSError *)validationError{
    if (self.block) {
        __weak typeof(self) weakSelf = self;
        dispatch_main_safe_async(^{
            __strong typeof(weakSelf) strongSelf = weakSelf;
            strongSelf.block(NO, nil,validationError);
        });
    }
}
@end
