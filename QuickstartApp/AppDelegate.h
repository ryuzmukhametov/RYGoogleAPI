//
//  AppDelegate.h
//  QuickstartApp
//
//  Created by ryuzmukhametov on 16/08/16.
//  Copyright © 2016 Rustam Yuzmukhametov. All rights reserved.
//

#import <UIKit/UIKit.h>

static NSString *ClientID = @"PUT_YOUR_CLIENT_ID_HERE";

// https://developers.google.com/people/api/rest/
// static NSString *KeychainItemName = @"People API";
// static NSString *FetchContactsURL = @"https://people.googleapis.com/v1/people/me/connections?requestMask.includeField=person.email_addresses,person.names,person.photos";
// #define Scopes @[@"https://www.googleapis.com/auth/contacts.readonly",@"https://www.googleapis.com/auth/plus.login",@"https://www.googleapis.com/auth/user.emails.read"]


// https://developers.google.com/google-apps/contacts/v3/
static NSString *KeychainItemName = @"Contacts API";
static NSString *FetchContactsURL = @"https://www.google.com/m8/feeds/contacts/default/full?max-results=100&alt=json";
static NSString *ContactsScope = @"https://www.googleapis.com/auth/contacts.readonly";


@interface AppDelegate : UIResponder <UIApplicationDelegate>
@property (strong, nonatomic) UIWindow *window;
@end

