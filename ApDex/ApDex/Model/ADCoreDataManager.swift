//
//  ADCoreDataManager.swift
//  ApDex
//
//  Created by Iuri Cernov on 7/19/17.
//  Copyright © 2017 Iuri Cernov. All rights reserved.
//

import Foundation
import MagicalRecord
import RestKit

class ADCoreDataManager {
    static func setUpEnvironment() -> Bool {
        let url = NSPersistentStore.mr_defaultLocalStoreUrl()
        MagicalRecord.setShouldAutoCreateManagedObjectModel(true)
        let defaultCoordinator = NSPersistentStoreCoordinator.mr_coordinatorWithAutoMigratingSqliteStore(at: url)
        
        let managedObjectStore = RKManagedObjectStore.init(persistentStoreCoordinator: defaultCoordinator)
        managedObjectStore!.createManagedObjectContexts()
        
        RKManagedObjectStore.default().managedObjectCache = RKInMemoryManagedObjectCache.init(
            managedObjectContext: RKManagedObjectStore.default().persistentStoreManagedObjectContext)
        
        NSPersistentStoreCoordinator.mr_setDefaultStoreCoordinator(defaultCoordinator)
        NSManagedObjectContext.mr_setRootSaving(managedObjectStore?.persistentStoreManagedObjectContext)
        NSManagedObjectContext.mr_setDefaultContext(managedObjectStore?.mainQueueManagedObjectContext)
        
        return RKManagedObjectStore.default() != nil && NSPersistentStore.mr_default() != nil
    }
}

