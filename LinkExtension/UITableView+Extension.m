//
//  UITableView+Extension.m
//  LinkScrollViewDemo
//
//  Created by Max on 2018/5/17.
//  Copyright © 2018年 Max. All rights reserved.
//

#import "UITableView+Extension.h"

#define SCREEN_WIDTH [[UIScreen mainScreen] bounds].size.width
#define SCREEN_HEIGHT [[UIScreen mainScreen] bounds].size.height

@implementation UITableView (Extension)
- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    if (point.y<SCREEN_HEIGHT - 200) {
        return NO;
    }
    return YES;
}
@end
