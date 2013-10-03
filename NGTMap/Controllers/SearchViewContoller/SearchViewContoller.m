//
//  SearchViewContoller.m
//  NGTMap
//
//  Created by Alexey Bromot on 03.10.13.
//  Copyright (c) 2013 Alexey Bromot. All rights reserved.
//

#import "SearchViewContoller.h"

@interface SearchViewContoller ()

@end

@implementation SearchViewContoller

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)blockOperation: (SimpleCompletionBlock)block {
    NSLog(@"dddd");
    
    block();
}

@end
