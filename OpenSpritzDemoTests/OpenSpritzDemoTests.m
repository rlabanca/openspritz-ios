//
//  OpenSpritzDemoTests.m
//  OpenSpritzDemoTests
//
//  Created by Francesco Mattia on 07/03/14.
//  Copyright (c) 2014 Fr4ncis. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "OSSpritz.h"

@interface OpenSpritzDemoTests : XCTestCase {
    NSString *animalFarm;
}

@end

@implementation OpenSpritzDemoTests

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    animalFarm = @"Mr. Jones, of the Manor Farm, had locked the hen-houses for the night, but was too drunk to remember to shut the pop-holes. With the ring of light from his lantern dancing from side to side, he lurched across the yard, kicked off his boots at the back door, drew himself a last glass of beer from the barrel in the scullery, and made his way up to bed, where Mrs. Jones was already snoring.";
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample
{
    NSLog(@"");
}

- (void)testPivot
{
	for (NSString *word in [animalFarm componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]])
	{
		NSLog(@"pivot for %@ is %i", word, [OSSpritz findPivot:word]);
	}
}

@end
