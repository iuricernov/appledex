//
//  RestKit-Bridge.h
//  ApDex
//
//  Created by Iuri Cernov on 7/19/17.
//  Copyright © 2017 Iuri Cernov. All rights reserved.
//

#ifndef RestKit_Bridge_h
#define RestKit_Bridge_h

#import <RestKit/RestKit.h>

// Use a class extension to expose access to MagicalRecord's private setter methods
@interface NSManagedObjectContext ()
+ (void)MR_setRootSavingContext:(NSManagedObjectContext *)context;
+ (void)MR_setDefaultContext:(NSManagedObjectContext *)moc;
@end

#endif /* RestKit_Bridge_h */
