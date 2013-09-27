//
//  Car.m
//  ngtmap
//
//  Created by vas3k on 12.02.12.
//

#import "Car.h"
#import "Transport.h"

@interface Car()
//they are unused? check and delete if they are
@property (nonatomic, readwrite, copy) NSString *title;
@property (nonatomic, readwrite, copy) NSString *subtitle;
@end

@implementation Car

@synthesize transport, timetable, timetableNearPoint, timetableNearTime, speed;
@synthesize title, subtitle, coordinate;
@synthesize azimuth;

- (id)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if (self) 
    {
        self.transport = [dictionary valueForKey:@"transport"];
        self.timetable = [dictionary valueForKey:@"timetable"];
        self.azimuth = - [[dictionary valueForKey:@"azimuth"] floatValue];
        self.speed = [dictionary valueForKey:@"speed"];

        // Определение ближайшей остановки
        NSUInteger splitterPos = [self.timetable rangeOfString:@"|"].location;
        if (splitterPos <= [self.timetable length]) 
        {
            NSArray *timetableNear = [[self.timetable substringToIndex:splitterPos] componentsSeparatedByString:@"+"];
            if ([timetableNear count] == 2) 
            {
                self.timetableNearTime = [timetableNear objectAtIndex:0];
                self.timetableNearPoint = [timetableNear objectAtIndex:1];
            }
            else
            {
                self.timetableNearTime = @"XX:XX";
                self.timetableNearPoint = [self.timetable substringToIndex:splitterPos];
            }            
        }
        else
        {
            self.timetableNearTime = @"XX:XX";
            self.timetableNearPoint = @"Остановка неизвестна";
        }
        coordinate = CLLocationCoordinate2DMake([[dictionary valueForKey:@"lat"] doubleValue], [[dictionary valueForKey:@"lon"] doubleValue]);
        self.title = self.transport.number;
        self.subtitle = self.transport.canonicalType;
    }
    return self;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"%@", self.transport];
}

- (void)dealloc {
    self.timetableNearPoint = nil;
    self.timetableNearTime = nil;
    self.timetable = nil;
    self.transport = nil;
    self.subtitle = nil;
    self.speed = nil;
    self.title = nil;
    [super dealloc];
}

@end
