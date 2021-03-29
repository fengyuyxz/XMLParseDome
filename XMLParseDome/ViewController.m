//
//  ViewController.m
//  XMLParseDome
//
//  Created by xuezhou.yan on 2021/3/29.
//

#import "ViewController.h"
#import "XMLParseManager.h"
//#import "GDataXMLNode.h"
@interface ViewController ()
@property (nonatomic, strong) XMLParseManager *manager;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self paresXML];
}
-(void)gDataXMLPares{
    // 1 加载xml文档
    /*
    NSString *path = [[NSBundle mainBundle]pathForResource:@"xmlTextFile" ofType:@"xml"];
    NSURL *url = [NSURL fileURLWithPath:path];
    NSData *data = [NSData dataWithContentsOfURL:url];
    NSError *error= nil;
    GDataXMLDocument *doc = [[GDataXMLDocument alloc]initWithData:data options:0 error:&error];
   // 2 拿到根元素,得到根元素下所有子孙元素
    NSArray * elementList =[doc.rootElement elementsForName:@"book"];
    for (GDataXMLElement *element in elementList) {
        
        NSString *title=((GDataXMLElement *)[[element elementsForName:@"title"] firstObject]).stringValue;
        NSString *author=((GDataXMLElement *)[[element elementsForName:@"author"] firstObject]).stringValue;
        NSString *year=((GDataXMLElement *)[[element elementsForName:@"year"] firstObject]).stringValue;
        NSString *price=((GDataXMLElement *)[[element elementsForName:@"price"] firstObject]).stringValue;
        NSLog(@"title = %@  author = %@  year = %@ price = %@",title,author,year,price);

    }*/
}
-(void)paresXML{
    NSString *path = [[NSBundle mainBundle]pathForResource:@"xmlTextFile" ofType:@"xml"];
    NSURL *url = [NSURL fileURLWithPath:path];
    _manager=[[XMLParseManager alloc]init];
    [_manager parseXMLWithURL:url completion:^(BOOL SUC, XPDXMLElement *data,NSError *error) {
        if (SUC) {
            NSLog(@"%@",data);
        }else{
            NSLog(@"error = %@",error);
        }
    }];
    NSLog(@"start == ");
    
}

@end
