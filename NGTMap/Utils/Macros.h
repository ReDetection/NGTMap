//For abstract classes
#define mustOverride() @throw [NSException exceptionWithName:NSInvalidArgumentException reason:\
[NSString stringWithFormat:@"%s must be overridden in a subclass/category", __PRETTY_FUNCTION__] userInfo:nil]
#define methodNotImplemented() mustOverride()

#define DOCUMENTS_FOLDER [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0]

#define NOVOSIVIRSK_DEFAULT_LATITUDE 55.033333
#define NOVOSIVIRSK_DEFAULT_LONGITUDE 82.916667
#define NOVOSIBIRSK_COORDINATES_REGION MKCoordinateRegionMake(CLLocationCoordinate2DMake(NOVOSIVIRSK_DEFAULT_LATITUDE, NOVOSIVIRSK_DEFAULT_LONGITUDE), MKCoordinateSpanMake(0.1, 0.1))

#define NOVOSIBIRSK_CLLocationCoordinate2D CLLocationCoordinate2DMake(55.033333, 82.916667)

#define IS_IOS7 ([UIDevice currentDevice].systemVersion.floatValue >= 7.0)
#define IS_IPAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)