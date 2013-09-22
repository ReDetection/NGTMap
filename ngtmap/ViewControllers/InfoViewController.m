//
//  InfoViewController.m
//  ngtmap
//
//  Created by vas3k on 12.02.12.
//

#import "InfoViewController.h"

@implementation InfoViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (IBAction)hideMe {
    if ([self respondsToSelector:@selector(dismissViewControllerAnimated:completion:)]){
        [self dismissViewControllerAnimated:YES completion:nil];        
    } else {
        [self dismissModalViewControllerAnimated:YES];
    }
}

- (IBAction)donate:(id)sender {
    NSURL *url = [[NSURL alloc] initWithString:@"http://vas3k.ru/donate/"];
    [[UIApplication sharedApplication] openURL:url];
    [url release];
}

#pragma mark - View Rotation

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
