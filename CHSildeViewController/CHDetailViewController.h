//
//  CHDetailViewController.h
//  CHSildeViewController
//
//  Created by Charles Hagman on 2/25/12.
//  Copyright (c) 2012 Deloitte. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CHSlideViewController.h"

@interface CHDetailViewController : UIViewController <CHSlideViewControllerDelegate> {
    UILabel *_textLabel;
    
    CHSlideViewController *_slideViewController;
}

@property (nonatomic, retain) IBOutlet UILabel *textLabel;
@property (nonatomic, assign) CHSlideViewController *slideViewController;

@end
