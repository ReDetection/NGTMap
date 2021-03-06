//
//  TransportDataSource.h
//  ngtmap
//
//  Created by vas3k on 12.02.12.
//

#import <Foundation/Foundation.h>
#import "Car.h"
#import "Transport.h"

@class Car;
@class Transport;

@interface TransportDataSource : NSObject {
    NSMutableArray         *transportList;
    NSMutableArray  *filteredTransportList;
}

@property (nonatomic, retain) NSMutableArray *transportList;
@property (nonatomic, retain) NSMutableArray *filteredTransportList;

- (void)loadTransportDataTo:(id)callbackObject;
- (void)loadPeriodicalData;
- (NSArray *)getCarsForTransport:(Transport *)transport;
- (void)getCarsForTransport:(Transport *)transport to:(id)callbackObject;

- (NSInteger)numberOfSections;
- (NSInteger)numberOfRowsInSection:(NSInteger)section isFiltered:(BOOL)filtered;
- (NSInteger)filterList:(NSString *)searchText scope:(NSString *)scope;
- (Transport *)itemForIndexPath:(NSIndexPath *)indexPath isFiltered:(BOOL)filtered;

@end
