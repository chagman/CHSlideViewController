//
//  CHSlideViewController.h
//  CHSildeViewController
//
//  Created by Charles Hagman on 2/25/12.
//  Copyright (c) 2012 Deloitte. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CHSlideViewControllerDelegate <NSObject>

-(void)setDetailItem:(NSString *)item;
//-(void)didToggleViewTo:(BOOL)isShowing;

@end

@interface CHSlideViewController : UIViewController {
    
    //Array to hold the Master and Detail Views
    NSArray *_viewControllers;

}

@property (nonatomic, retain) NSArray *viewControllers;

-(void)slideView:(id)sender;

@end
