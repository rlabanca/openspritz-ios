//
//  OSSpritzLabel.h
//  OpenSpritzDemo
//
//  Created by Francesco Mattia on 08/03/14.
//  Copyright (c) 2014 Fr4ncis. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OSSpritzLabel : UIView
@property (nonatomic, strong) NSString *text;
@property (nonatomic, assign) int wordsPerMinute;

- (void)start;
- (void)pause;
@end
