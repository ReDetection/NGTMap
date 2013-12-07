//
//  NGTSidePanelController.m
//  NGTMap
//
//  Created by Bromot Alexey on 14.10.13.
//  Copyright (c) 2013 Alexey Bromot. All rights reserved.
//

#import "NGTSidePanelController.h"

#import <UIViewController+JASidePanel.h>

@implementation NGTSidePanelControllerCenterSegue

- (void)perform {
    UIViewController *sourceController = self.sourceViewController;
    sourceController.sidePanelController.centerPanel = self.destinationViewController;
}

@end

@implementation NGTSidePanelControllerEmptySegue

@end


@interface NGTSidePanelController ()

@end

@implementation NGTSidePanelController

-(void) awakeFromNib
{
    [self setLeftPanel:[self.storyboard instantiateViewControllerWithIdentifier:@"leftSideViewController"]];
    [self setCenterPanel:[self.storyboard instantiateViewControllerWithIdentifier:@"centerSideViewController"]];
}

- (void)stylePanel:(UIView *)panel {
    panel.clipsToBounds = YES;
}

@end
