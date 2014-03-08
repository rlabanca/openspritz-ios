//
//  OSViewController.m
//  OpenSpritzDemo
//
//  Created by Francesco Mattia on 07/03/14.
//  Copyright (c) 2014 Fr4ncis. All rights reserved.
//

#import "OSViewController.h"
#import "OSSpritzLabel.h"

@interface OSViewController () {
    OSSpritzLabel *osLabel;
    IBOutlet UILabel *wpmLabel;
}

@end

@implementation OSViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    NSString *animalFarm = @"Mr. Jones, of the Manor Farm, had locked the hen-houses for the night, but was too drunk to remember to shut the pop-holes. With the ring of light from his lantern dancing from side to side, he lurched across the yard, kicked off his boots at the back door, drew himself a last glass of beer from the barrel in the scullery, and made his way up to bed, where Mrs. Jones was already snoring.";
    
    osLabel = [[OSSpritzLabel alloc] initWithFrame:CGRectMake(0, 50, 320.0f, 40)];
    osLabel.text = animalFarm;
    [self.view addSubview:osLabel];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)startButtonPressed:(id)sender {
    [osLabel start];
}
- (IBAction)stopButtonPressed:(id)sender {
    [osLabel pause];
}

- (IBAction)sliderValue:(UISlider*)sender {
    [osLabel setWordsPerMinute:round(sender.value)];
    wpmLabel.text = [@(osLabel.wordsPerMinute) stringValue];
}

@end
