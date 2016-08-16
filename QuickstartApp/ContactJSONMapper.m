//
//  ContactJSONMapper.m
//  QuickstartApp
//
//  Created by ryuzmukhametov on 16/08/16.
//  Copyright © 2016 Rustam Yuzmukhametov. All rights reserved.
//

#import "ContactJSONMapper.h"
#import "ContactEntry.h"

@implementation ContactJSONMapper


- (NSArray*)fetchContactsFromJSON:(NSDictionary*)json {
    NSMutableArray *entries = [[NSMutableArray alloc] init];
    NSArray *dictEntries = json[@"feed"][@"entry"];
    
    for (NSDictionary *dictEntry in dictEntries) {
        ContactEntry *entry = [[ContactEntry alloc] init];
        entry.title = dictEntry[@"title"][@"$t"];
        
        NSArray *emailAddresses = dictEntry[@"gd$email"];
        if (emailAddresses.count > 0) {
            entry.email = emailAddresses[0][@"address"];
        }
        
        NSArray *links = dictEntry[@"link"];
        for (NSDictionary *link in links) {
            if ([link[@"type"] isEqualToString:@"image/*"]) {
                entry.imageURL = link[@"href"];
                break;
            }
        }
        [entries addObject:entry];
    }
    return entries;
}

/* version for Profile API
- (void)parseDictionary:(NSDictionary*)dict {
    NSArray *connections = dict[@"connections"];
    self.entries = [[NSMutableArray alloc] init];
    for (NSDictionary *connection in connections) {
        ContactEntry *entry = [[ContactEntry alloc] init];
        NSArray *names = connection[@"names"];
        NSArray *emailAddresses = connection[@"emailAddresses"];
        NSArray *photos = connection[@"photos"];
        if (names.count > 0) {
            entry.title = names[0][@"displayName"];
        }
        if (emailAddresses.count > 0) {
            entry.email = emailAddresses[0][@"value"];
        }
        if (photos.count > 0) {
            entry.imageURL = photos[0][@"url"];
        }
    }
}

*/

@end
