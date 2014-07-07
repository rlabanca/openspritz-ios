//
//  OSSpritzLabel.m
//  OpenSpritzDemo
//
//  Created by Francesco Mattia on 08/03/14.
//  Copyright (c) 2014 Fr4ncis. All rights reserved.
//

#import "OSSpritzLabel.h"
#import "OSSpritz.h"

#define kInterspace 2.0f
#define maxWordLength 18
#define pivotChar 9

@implementation NSString (Additions)

- (NSRange)safeRangeOfString:(NSString *)aString options:(NSStringCompareOptions)mask range:(NSRange)searchRange
{
    if (searchRange.location > self.length) searchRange.location = 0;
    if ((searchRange.location + searchRange.length) > self.length) searchRange.length = self.length - searchRange.location;
    return [self rangeOfString:aString options:mask range:searchRange];
}

@end

@implementation OSSpritzLabel {
    UIFont *font;
    NSArray *labelViews;
    NSArray *spritzedText;
    NSUInteger currentChar;
    NSUInteger currentWord;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUp];
    }
    return self;
}


- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder])
    {
        [self setUp];
    }
    return self;
}

- (void)setUp
{
    font = [UIFont fontWithName:@"Menlo-Bold" size:20.0f];
    float charWidth = [@"m" sizeWithAttributes:@{NSFontAttributeName:font}].width;
    for (int i = 0; i < 18; i++)
    {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(i*(charWidth+kInterspace), 0, charWidth, self.frame.size.height)];
        
        label.textAlignment = NSTextAlignmentCenter;
        label.font = font;
        label.backgroundColor = [UIColor clearColor];
        if (i==pivotChar) label.textColor = [UIColor colorWithRed:0 green:122/256.0 blue:255/256.0 alpha:1.0];
        label.alpha = 0;
        label.text = @"m";
        [self addSubview:label];
    }
    self.wordsPerMinute = 250;
    labelViews = [self.subviews copy];
    currentWord = 0;
    currentChar = 0;
    [self drawGuideLines];
}

- (void)drawGuideLines
{
    {
        float guideX = ((UIView*)labelViews[pivotChar]).center.x;
        float guideHeight = 9;
        //// Abstracted Attributes
        UIBezierPath* upperLinePath = [UIBezierPath bezierPathWithRect:CGRectMake(0,  0, self.frame.size.width, 1)];
        UIBezierPath* upperGuidePath = [UIBezierPath bezierPathWithRect:CGRectMake(guideX, 0, 1, self.frame.size.height)];
        UIBezierPath* downLinePath = [UIBezierPath bezierPathWithRect:CGRectMake(0, self.frame.size.height-1, self.frame.size.width, 1)];
        //UIBezierPath* downGuidePath = [UIBezierPath bezierPathWithRect:CGRectMake(guideX, self.frame.size.height-1-guideHeight, 1, guideHeight)];
        
        NSArray *paths = @[upperLinePath, upperGuidePath, downLinePath]; //, downLinePath];
        
        
        for (UIBezierPath *path in paths)
        {
            CAShapeLayer *line = [CAShapeLayer layer];
            line.path=path.CGPath;
            line.fillColor = [UIColor lightGrayColor].CGColor;
            line.opacity = 1.0;
            line.strokeColor = nil;
            [self.layer addSublayer:line];
        }
    }
}

- (void)setText:(NSString *)text
{
    _text = text;
    spritzedText = [OSSpritz spritzString:text];
}

- (void)start
{
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    if (currentWord >= [spritzedText count]) {
        currentWord = 0;
        currentChar = 0;
        return;
    }
    
    NSRange range = [self displayStringAndHighlight];
    if (range.location != NSNotFound) currentChar = range.location + range.length;
    
    float timeMod = [OSSpritz timeForWord:spritzedText[currentWord]];
    
    currentWord++;
    NSTimeInterval interval = 60.0 / (float)self.wordsPerMinute * timeMod;
    [self performSelector:@selector(start) withObject:nil afterDelay:interval];
}

// moves to the first word after the tapped point

- (BOOL)characterIsPartOfWordAtLocation:(int)location
{
    if (!self.text) return NO;
    static NSCharacterSet *separatorCharset;
    separatorCharset = [NSCharacterSet characterSetWithCharactersInString:@" \n\t"];
    return [[_text substringWithRange:(NSRange){location, 1}] stringByTrimmingCharactersInSet:separatorCharset].length == 0;
}

// when tapped on the textview get a locations and finds the current char / word

- (void)gotoWordAtLocation:(int)location
{
    while ([self characterIsPartOfWordAtLocation:location]) {
        location++;
    }
    
    // find currentWord and sets currentChar from char position
    currentChar = location;
    NSString *partial = [_text substringToIndex:currentChar+1];
    NSArray *spritzPartial = [OSSpritz spritzString:partial];
    
    
    int i = 0;
    while ([spritzPartial[i] isEqualToString:spritzedText[i]] && i < [spritzPartial count]-1) { i++; }
    
    currentChar = (currentChar > [spritzPartial[i] length] ? currentChar - [spritzPartial[i] length] : 0);
    currentWord = i;
    
    [self displayStringAndHighlight];
}

// puts the string in the label and highlights the range in the textview

- (NSRange)displayStringAndHighlight
{
    //NSLog(@"Display word: %d char: %d", currentWord, currentChar);
    if (!spritzedText) return (NSRange){NSNotFound, 0};
    
    NSString *currentWordStr = spritzedText[currentWord];
    [self placeInLabels:currentWordStr];
    
    if (currentWordStr.length == 0) return (NSRange){NSNotFound, 0}; // nothing to highlight
    
    // if last char of current word is - removes it for the search
    if ([currentWordStr length] > 0 && [[currentWordStr substringFromIndex:([currentWordStr length]-1)] isEqualToString:@"-"])
    {
        currentWordStr = [currentWordStr substringToIndex:[currentWordStr length]-1];
    }
    
    // Looks for the string in the text
    NSRange range = [_text safeRangeOfString:currentWordStr options:NSLiteralSearch range:(NSRange){currentChar,[_text length]}];
    
    NSLog(@"Range: [%@ %@]", @(range.location), @(range.length));
    NSAssert(!(range.location != NSNotFound && range.location > _text.length), @"Range found should not be over text length");
    
    if (range.location != NSNotFound)
    {
        // currentChar = range.location + range.length;
        // FIXME moves on currentChar.. review this
        
        if ([self.delegate respondsToSelector:@selector(didMoveToCurrentWord:Char:)])
        {
            [self.delegate didMoveToCurrentWord:currentWord Char:currentChar];
        }
        if ([self.delegate respondsToSelector:@selector(highlightRange:)])
        {
            [self.delegate highlightRange:range];
        }
        return range;
    }
    return (NSRange){NSNotFound, 0};
}

- (void)placeInLabels:(NSString*)word
{
    int offset = [OSSpritz offsetForWord:word];
    for (int i = 0; i < [labelViews count]; i++)
    {
        UILabel *label = ((UILabel*)labelViews[i]);
        if (i < offset)
        {
            label.alpha = 0;
        }
        else if (i >= offset && i < word.length + offset)
        {
            label.alpha = 1;
            label.text = [word substringWithRange:(NSRange){i-offset,1}];
        }
        else
        {
            label.alpha = 0;
        }
    }
}

// this is called only in the setup read

- (void)setProgressWithWord:(int)wordIndex Char:(int)charLocation
{
    currentWord = wordIndex;
    NSString *currentWordStr = spritzedText[currentWord];
    currentChar = charLocation-currentWordStr.length;
    [self displayStringAndHighlight];
}

- (float)progress
{
    if (spritzedText)
    {
        return currentWord/[spritzedText count];
    }
    return 0;
}

- (void)pause
{
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
}

@end