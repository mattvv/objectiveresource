//
//  Response.m
//  medaxion
//
//  Created by Ryan Daigle on 7/30/08.
//  Copyright 2008 yFactorial, LLC. All rights reserved.
//

#import "Response.h"
#import "NSHTTPURLResponse+Error.h"

@implementation Response

@synthesize body, headers, statusCode, error;

+ (id)responseFrom:(NSHTTPURLResponse *)response withBody:(NSData *)data andError:(NSError *)aError {
	return [[[self alloc] initFrom:response withBody:data andError:aError] autorelease];
}

- (id)initFrom:(NSHTTPURLResponse *)response withBody:(NSData *)data andError:(NSError *)aError {
	[self init];
	self.body = data;
	if(response) {
		self.statusCode = [response statusCode];
		self.headers = [response allHeaderFields];
		self.error = [response error];		
	}
	else {
		self.error = aError;
	}
	return self;
}

- (BOOL)isSuccess {
	return statusCode >= 200 && statusCode < 400;
}

- (BOOL)isError {
	return ![self isSuccess];
}

- (void)log {
	if ([self isSuccess]) {
		debugLog(@"<= %@", [[[NSString alloc] initWithData:body encoding:NSUTF8StringEncoding] autorelease]);
	}
	else {
		NSLog(@"<= %@", [[[NSString alloc] initWithData:body encoding:NSUTF8StringEncoding] autorelease]);
	}
}

#pragma mark cleanup

- (void) dealloc
{
	[body release];
	[headers release];
	[super dealloc];
}


@end
