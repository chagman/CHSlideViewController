//
//  CHSlideViewController.m
//  CHSildeViewController
//
//  Created by Charles Hagman on 2/25/12.
/*  Copyright (C) 2012 Charles Hagman
 
 Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE. 
 */

#import "CHSlideViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface CHSlideViewController () {
    //variable that tracks if the MasterView is displaying
    BOOL _showingMaster;
    
    //gesture that allows the user to tap any where on the detail view to bring it back to the left corner
    UITapGestureRecognizer *_tapGesture;
}

@property (nonatomic) BOOL showingMaster;
@property (nonatomic, retain) UITapGestureRecognizer *tapGesture;

//Method invoked for tapgesture
-(void)touchedEdge:(UIGestureRecognizer *)gesture;
//Methods to access the detailView and MasterView
//will make it easier if I refactor the code in the future
-(UIViewController *)detailViewController;
-(UIViewController *)masterViewController;

@end

//lenght of the slide animation
#define ANIMATION_DURATION .3
//height of the toolbar
#define TOOLBAR_HEIGHT 44
//x position to slide the detailview to reveal the masterview
#define X_POS_SHOWING_MASTER 269

@implementation CHSlideViewController

@synthesize viewControllers=_viewControllers, showingMaster=_showingMaster, tapGesture=_tapGesture;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    
    }
    return self;
}

-(UIViewController *)detailViewController {
    return (UIViewController *)[self.viewControllers objectAtIndex:1];
}

-(UIViewController *)masterViewController {
    return (UIViewController *)[self.viewControllers objectAtIndex:0];
}

-(void)slideView:(id)sender {
    
    if (!self.showingMaster) {
        [UIView animateWithDuration:ANIMATION_DURATION animations:^{
            UIViewController *detailViewController = [self detailViewController];
            //reveal amount
            float x = X_POS_SHOWING_MASTER;
            CGRect currentFrame = detailViewController.view.frame;
            CGRect moveFrameTo = CGRectMake(x, currentFrame.origin.y, currentFrame.size.width, currentFrame.size.height);
            detailViewController.view.frame = moveFrameTo;
        }
        completion:^(BOOL finished){
            //When finished the animation add the gesture to move the view back into place
            UIViewController *detailViewController = [self detailViewController];
            [detailViewController.view addGestureRecognizer:self.tapGesture];
        }];
    } else {
        [UIView animateWithDuration:ANIMATION_DURATION animations:^{
            UIViewController *detailViewController = (UIViewController *)[self.viewControllers objectAtIndex:1];
            //reveal amount
            float x = 0;
            CGRect currentFrame = detailViewController.view.frame;
            CGRect moveFrameTo = CGRectMake(x, currentFrame.origin.y, currentFrame.size.width, currentFrame.size.height);
            detailViewController.view.frame = moveFrameTo;
        } 
        completion:^(BOOL finished){
            //Remove the gesture so the user has to hit the UIBarButton to toggle the view
            UIViewController *detailViewController = [self detailViewController];
            [detailViewController.view removeGestureRecognizer:self.tapGesture];
        }];
    }
    self.showingMaster = !self.showingMaster;
    
}

- (void)loadView
{
    //Create a view for the slideviewcontroller
    CGRect frame = [[[[UIApplication sharedApplication] delegate] window] frame];
    UIView *view = [[UIView alloc] initWithFrame:frame];
    self.view = view;
    
    [view release];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    //Add a toolbar at the top
    CGRect toolbarFrame = CGRectMake(0, 0, self.view.frame.size.width, TOOLBAR_HEIGHT);
    UIToolbar *toolbar = [[UIToolbar alloc] initWithFrame:toolbarFrame];
    
    //Put button that manages the slide action in the toolbar
    UIImage *buttonImage = [UIImage imageNamed:@"slideButtonImage.png"];
    UIBarButtonItem *slideButton = [[UIBarButtonItem alloc] initWithImage:buttonImage 
                                                                    style:UIBarButtonItemStylePlain
                                                                   target:self 
                                                                   action:@selector(slideView:)];
    slideButton.style = UIBarButtonItemStyleBordered;
    
    [toolbar setItems:[NSArray arrayWithObject:slideButton]];
    
    //offset the tableview and detailView by the height of the toolbar
    //float yOffset = toolbarFrame.size.height;
    
    //add the tableview controller
    CGRect tableViewFrame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    //self.tableViewController.view.frame =tableViewFrame;
    //[self.view addSubview:self.tableViewController.view];
    UIViewController *masterController = [self masterViewController];
    masterController.view.frame = tableViewFrame;
    [self.view addSubview:masterController.view];
    
    //add the detailViewController on top of it
    CGRect detailViewFrame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    UIViewController *detailController = [self detailViewController];
    detailController.view.frame = detailViewFrame;
    
    //Add the toolbar to the view
    [detailController.view addSubview:toolbar];
    
    //Add a gesture to the view to slide out
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self 
                                                                              action:@selector(touchedEdge:)];
    self.tapGesture = gesture;
    if (self.showingMaster) {
        [detailController.view addGestureRecognizer:gesture];
    }
    
    //Add a shadow on the top view controller
    detailController.view.layer.masksToBounds = NO;
    detailController.view.layer.shadowOffset = CGSizeMake(-2, 0);
    detailController.view.layer.shadowOpacity = 0.4;
    
    [self.view addSubview:detailController.view];
    
    [toolbar release];
    [slideButton release];
    [gesture release];
    
}

//If the user selects the detailView while showing the masters
-(void)touchedEdge:(UIGestureRecognizer *)gesture {
    if (gesture.state == UIGestureRecognizerStateEnded && self.showingMaster) {
        [self slideView:self];
    }
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

-(void)dealloc {
    [_viewControllers release];
    [super dealloc];
}

@end
