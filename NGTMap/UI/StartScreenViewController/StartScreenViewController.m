//
//  StartScreenViewController.m
//  NGTMap
//
//  Created by Bromot Alexey on 14.10.13.
//  Copyright (c) 2013 Alexey Bromot. All rights reserved.
//

#import "StartScreenViewController.h"

#import <MBProgressHUD.h>

@interface StartScreenViewController ()


@end

@implementation StartScreenViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    MBProgressHUD *progressIndicator = [[MBProgressHUD alloc] initWithView:self.view];
	[self.view addSubview:progressIndicator];
	
	progressIndicator.labelText = @"Загрузка...";
	progressIndicator.square = YES;
	progressIndicator.dimBackground = YES;
	
    [progressIndicator show:YES];
    
    [[ServiceProvider sharedProvider] getAllRoutesSuccessHandler:^(NSArray *routes) {
        [progressIndicator hide:YES];
        
        [DataManager sharedManager].routes = routes;
        [self performSegueWithIdentifier:@"sidePanelControllerSequeIdentifier" sender:self];
        
    } failHandler:^(NSError *error) {
        [progressIndicator hide:YES];
    }];
}

@end
