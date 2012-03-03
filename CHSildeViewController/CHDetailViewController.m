//
//  CHDetailViewController.m
//  CHSildeViewController
//
//  Created by Charles Hagman on 2/25/12.
//  Copyright (c) 2012 Deloitte. All rights reserved.
//

#import "CHDetailViewController.h"

@interface CHDetailViewController () {
    BOOL _showingMaster;
}

@property (nonatomic) BOOL showingMaster;

@end

@implementation CHDetailViewController

@synthesize textLabel=_textLabel, slideViewController=_slideViewController, showingMaster =_showingMaster;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

-(void)setDetailItem:(NSString *)item {
    self.textLabel.text = item;
    [self.slideViewController slideView:self];
}

-(void)dealloc {
    [_textLabel release];
    [super dealloc];
}

@end
