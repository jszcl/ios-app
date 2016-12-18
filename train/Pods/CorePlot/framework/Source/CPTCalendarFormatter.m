#import "CPTCalendarFormatter.h"

#import "CPTExceptions.h"

/** @brief A number formatter that converts calendar intervals to dates.
 *
 *  Useful for formatting labels on an axis. The numerical
 *  scale of the plot space will be used to increment the specified calendar unit.
 *  For example, with a @link CPTAxis::majorIntervalLength majorIntervalLength @endlink of one (@num{1}) and a
 *  @ref referenceCalendarUnit of
 *  @ref NSMonthCalendarUnit, successive months will be displayed on the axis.
 *  Axis labels can be directly generated by setting a CPTCalendarFormatter as the @link CPTAxis::labelFormatter labelFormatter @endlink
 *  and/or @link CPTAxis::minorTickLabelFormatter minorTickLabelFormatter @endlink.
 **/
@implementation CPTCalendarFormatter

/** @property nullable NSDateFormatter *dateFormatter
 *  @brief The date formatter used to generate strings from date calculations.
 **/
@synthesize dateFormatter;

/** @property nullable NSDate *referenceDate
 *  @brief Date from which time intervals are computed.
 *  If @nil, the standard reference date (1 January 2001, GMT) is used.
 **/
@synthesize referenceDate;

/** @property nullable NSCalendar *referenceCalendar
 *  @brief Calendar which is used for date calculations.
 *  If @nil, the current calendar is used.
 **/
@synthesize referenceCalendar;

/** @property NSCalendarUnit referenceCalendarUnit
 *  @brief Calendar unit which is incremented in the date calculation.
 *  If zero (@num{0}), the date is incremented.
 **/
@synthesize referenceCalendarUnit;

#pragma mark -
#pragma mark Init/Dealloc

/// @name Initialization
/// @{

/** @brief Initializes a newly allocated CPTCalendarFormatter object with a default date formatter.
 *  The default formatter uses @ref NSDateFormatterMediumStyle for dates and times.
 *  @return The initialized object.
 **/
-(nonnull instancetype)init
{
    NSDateFormatter *newDateFormatter = [[NSDateFormatter alloc] init];

    newDateFormatter.dateStyle = NSDateFormatterMediumStyle;
    newDateFormatter.timeStyle = NSDateFormatterMediumStyle;

    self = [self initWithDateFormatter:newDateFormatter];

    return self;
}

/// @}

/** @brief Initializes new instance with the date formatter passed.
 *  @param aDateFormatter The date formatter.
 *  @return The new instance.
 **/
-(nonnull instancetype)initWithDateFormatter:(nullable NSDateFormatter *)aDateFormatter
{
    if ( (self = [super init]) ) {
        dateFormatter         = aDateFormatter;
        referenceDate         = nil;
        referenceCalendar     = nil;
        referenceCalendarUnit = NSCalendarUnitEra;
    }
    return self;
}

#pragma mark -
#pragma mark NSCoding Methods

/// @cond

-(void)encodeWithCoder:(nonnull NSCoder *)coder
{
    [super encodeWithCoder:coder];

    [coder encodeObject:self.dateFormatter forKey:@"CPTCalendarFormatter.dateFormatter"];
    [coder encodeObject:self.referenceDate forKey:@"CPTCalendarFormatter.referenceDate"];
    [coder encodeObject:self.referenceCalendar forKey:@"CPTCalendarFormatter.referenceCalendar"];
    [coder encodeInteger:(NSInteger)self.referenceCalendarUnit forKey:@"CPTCalendarFormatter.referenceCalendarUnit"];
}

/// @endcond

/** @brief Returns an object initialized from data in a given unarchiver.
 *  @param coder An unarchiver object.
 *  @return An object initialized from data in a given unarchiver.
 */
-(nullable instancetype)initWithCoder:(nonnull NSCoder *)coder
{
    if ( (self = [super init]) ) {
        dateFormatter         = [coder decodeObjectForKey:@"CPTCalendarFormatter.dateFormatter"];
        referenceDate         = [[coder decodeObjectForKey:@"CPTCalendarFormatter.referenceDate"] copy];
        referenceCalendar     = [[coder decodeObjectForKey:@"CPTCalendarFormatter.referenceCalendar"] copy];
        referenceCalendarUnit = (NSCalendarUnit)[coder decodeIntegerForKey:@"CPTCalendarFormatter.referenceCalendarUnit"];
    }
    return self;
}

#pragma mark -
#pragma mark NSCopying Methods

/// @cond

-(nonnull id)copyWithZone:(nullable NSZone *)zone
{
    CPTCalendarFormatter *newFormatter = [[CPTCalendarFormatter allocWithZone:zone] init];

    if ( newFormatter ) {
        newFormatter.dateFormatter         = self.dateFormatter;
        newFormatter.referenceDate         = self.referenceDate;
        newFormatter.referenceCalendar     = self.referenceCalendar;
        newFormatter.referenceCalendarUnit = self.referenceCalendarUnit;
    }
    return newFormatter;
}

/// @endcond

#pragma mark -
#pragma mark Formatting

/// @name Formatting
/// @{

/**
 *  @brief Converts decimal number for the time into a date string.
 *  Uses the date formatter to do the conversion. Conversions are relative to the
 *  reference date, unless it is @nil, in which case the standard reference date
 *  of 1 January 2001, GMT is used.
 *  @param coordinateValue The time value.
 *  @return The date string.
 **/
-(NSString *)stringForObjectValue:(id)coordinateValue
{
    NSInteger componentIncrement = 0;

    if ( [coordinateValue respondsToSelector:@selector(integerValue)] ) {
        componentIncrement = [coordinateValue integerValue];
    }

    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];

    switch ( self.referenceCalendarUnit ) {
        case NSCalendarUnitEra:
            dateComponents.era = componentIncrement;
            break;

        case NSCalendarUnitYear:
            dateComponents.year = componentIncrement;
            break;

        case NSCalendarUnitMonth:
            dateComponents.month = componentIncrement;
            break;

        case NSCalendarUnitDay:
            dateComponents.day = componentIncrement;
            break;

        case NSCalendarUnitHour:
            dateComponents.hour = componentIncrement;
            break;

        case NSCalendarUnitMinute:
            dateComponents.minute = componentIncrement;
            break;

        case NSCalendarUnitSecond:
            dateComponents.second = componentIncrement;
            break;

        case NSCalendarUnitWeekday:
            dateComponents.weekday = componentIncrement;
            break;

        case NSCalendarUnitWeekdayOrdinal:
            dateComponents.weekdayOrdinal = componentIncrement;
            break;

#if MAC_OS_X_VERSION_10_5 < MAC_OS_X_VERSION_MAX_ALLOWED || __IPHONE_3_0 < __IPHONE_OS_VERSION_MAX_ALLOWED
        case NSCalendarUnitQuarter:
            if ( [dateComponents respondsToSelector:@selector(setQuarter:)] ) {
                dateComponents.quarter = componentIncrement;
            }
            else {
                [NSException raise:CPTException format:@"Unsupported calendar unit: NSQuarterCalendarUnit"];
            }
            break;
#endif
#if MAC_OS_X_VERSION_10_6 < MAC_OS_X_VERSION_MAX_ALLOWED || __IPHONE_4_0 < __IPHONE_OS_VERSION_MAX_ALLOWED
        case NSCalendarUnitWeekOfMonth:
            if ( [dateComponents respondsToSelector:@selector(setWeekOfMonth:)] ) {
                dateComponents.weekOfMonth = componentIncrement;
            }
            else {
                [NSException raise:CPTException format:@"Unsupported calendar unit: NSWeekOfMonthCalendarUnit"];
            }
            break;

        case NSCalendarUnitWeekOfYear:
            if ( [dateComponents respondsToSelector:@selector(setWeekOfYear:)] ) {
                dateComponents.weekOfYear = componentIncrement;
            }
            else {
                [NSException raise:CPTException format:@"Unsupported calendar unit: NSWeekOfYearCalendarUnit"];
            }
            break;

        case NSCalendarUnitYearForWeekOfYear:
            if ( [dateComponents respondsToSelector:@selector(setYearForWeekOfYear:)] ) {
                dateComponents.yearForWeekOfYear = componentIncrement;
            }
            else {
                [NSException raise:CPTException format:@"Unsupported calendar unit: NSYearForWeekOfYearCalendarUnit"];
            }
            break;
#endif
#if MAC_OS_X_VERSION_10_7 < MAC_OS_X_VERSION_MAX_ALLOWED || __IPHONE_4_0 < __IPHONE_OS_VERSION_MAX_ALLOWED
        case NSCalendarUnitCalendar:
            [NSException raise:CPTException format:@"Unsupported calendar unit: NSCalendarCalendarUnit"];
            break;

        case NSCalendarUnitTimeZone:
            [NSException raise:CPTException format:@"Unsupported calendar unit: NSTimeZoneCalendarUnit"];
            break;
#endif
#if MAC_OS_X_VERSION_10_8 < MAC_OS_X_VERSION_MAX_ALLOWED || __IPHONE_4_0 < __IPHONE_OS_VERSION_MAX_ALLOWED
        default:
            [NSException raise:CPTException format:@"Unsupported calendar unit"];
            break;
#endif
    }

    NSDate *startDate = [NSDate dateWithTimeIntervalSinceReferenceDate:0];
    if ( self.referenceDate ) {
        startDate = self.referenceDate;
    }

    NSCalendar *calendar = [NSCalendar currentCalendar];
    if ( self.referenceCalendar ) {
        calendar = self.referenceCalendar;
    }

    NSDate *computedDate = [calendar dateByAddingComponents:dateComponents toDate:startDate options:0];

    NSString *string = [self.dateFormatter stringFromDate:computedDate];
    return string;
}

/// @}

@end
