//
//  ContactJSONMapper.h
//  QuickstartApp
//
//  Created by ryuzmukhametov on 16/08/16.
//  Copyright © 2016 Rustam Yuzmukhametov. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ContactJSONMapper : NSObject
- (NSArray*)fetchContactsFromJSON:(NSDictionary*)json;
@end
