//
//  ViewController.h
//  StockView
//
//  Created by Jezz on 2017/10/14.
//  Copyright © 2017年 Jezz. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_OPTIONS(NSUInteger, kActionType) {
    kActionTypeTop    =    1 << 0, // 1
    kActionTypeBottom =    1 << 1, // 2
    kActionTypeLeft   =    1 << 2, // 4
    kActionTypeRight  =    1 << 3, // 8
};



@interface DemoViewController : UIViewController


@end

