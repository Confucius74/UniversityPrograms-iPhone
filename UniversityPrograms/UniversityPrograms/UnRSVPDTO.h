//
//  UnRSVPDTO.h
//  UniversityPrograms
//
//  Created by Miles Crabbe on 6/6/14.
//  Copyright (c) 2014 CAPS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UnRSVPDTO : NSObject
//post function require a body, our body consists of objects
//so we must make a transferable object
@property NSString *cwid;
@property NSString *eventId;
-(void)buildWithEventId:(NSString *)eventID;
@end
