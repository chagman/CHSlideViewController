//
//  CHTableViewController.h
//  CHSildeViewController
//
//  Created by Charles Hagman on 3/1/12.
//  Copyright (c) 2012 Deloitte. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CHSlideViewController.h"

@interface CHTableViewController : UITableViewController {
    NSArray *_navigationOptions;
    
    id<CHSlideViewControllerDelegate> _detailDelegate;
}

@property (nonatomic, retain) NSArray *navigationOptions;
@property (nonatomic, assign) id<CHSlideViewControllerDelegate> detailDelegate;

@end
