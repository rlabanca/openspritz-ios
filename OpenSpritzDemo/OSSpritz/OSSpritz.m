//
//  OSSpritz.m
//  OpenSpritzDemo
//
//  Created by Francesco Mattia on 07/03/14.
//  Copyright (c) 2014 Fr4ncis. All rights reserved.
//

#import "OSSpritz.h"

@implementation OSSpritz

+ (int)offsetForWord:(NSString*)word
{
    return 9 - [OSSpritz findPivot:word];
}

// pivot finding source, simplified.
+ (NSUInteger)findPivot:(NSString *)word
{
	NSUInteger wordLength = [word length];
	NSUInteger pivot = (wordLength + 2) / 4;
	if (pivot > 4)
	{
		pivot = 4;
	}
	
	if ([word characterAtIndex:pivot] == ' ')
	{
		pivot--;
	}
	
	NSAssert(pivot >= 0 && pivot < 5,@"pivot for word %@ out of range, computed as %i", word, pivot);
	
	return pivot;
};


+ (NSArray*)spritzString:(NSString*)text
{
    return [text componentsSeparatedByString:@" "];
}

+ (float)timeForWord:(NSString*)word
{
    NSRange strongRange = [word rangeOfCharacterFromSet:[NSCharacterSet characterSetWithCharactersInString:@".:?!"]];
    NSRange weakRange = [word rangeOfCharacterFromSet:[NSCharacterSet characterSetWithCharactersInString:@",-("]];
    if (strongRange.location != NSNotFound) return 3;
    if (weakRange.location != NSNotFound) return 2;
    if (word.length >= 8) return 2;
    return 1;
}

@end
