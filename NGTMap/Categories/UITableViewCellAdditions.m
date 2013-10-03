/*
 * Arello Mobile
 * Mobile Framework
 * Except where otherwise noted, this work is licensed under a Creative Commons Attribution 3.0 Unported License
 * http://creativecommons.org/licenses/by/3.0
 */

#import "UITableViewCellAdditions.h"
#import "NSObject-ClassName.h"

@implementation UITableViewCell (Additions)

+(id) createTableViewCell {	
 	return [[[NSBundle mainBundle] loadNibNamed:[self className] owner:nil options:nil] objectAtIndex:0];
}

+(id) createTableViewCellForTable:(UITableView*) table {
	UITableViewCell* result = [table dequeueReusableCellWithIdentifier:[self className]];
	if (!result)
		result = [self createTableViewCell];
	
	return result;
}

@end
