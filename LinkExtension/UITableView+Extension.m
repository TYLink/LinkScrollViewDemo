//
//  UITableView+Extension.m
//  LinkScrollViewDemo
//
//  Created by Max on 2018/5/17.
//  Copyright © 2018年 Max. All rights reserved.
//

#import "UITableView+Extension.h"

@implementation UITableView (Extension)
- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    if (point.y<400) {
        return NO;
    }
    return YES;
}
@end
