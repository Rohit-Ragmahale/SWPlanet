//
//  AppDataServiceProviderTests.swift
//  SWPlanetsTests
//
//  Created by Rohit Ragmahale on 18/04/2023.
//

import XCTest

final class AppDataServiceProviderTests: XCTestCase {
    var networkMonitor = MockNetworkMonitor()
    var offlineService = MockOfflineService()
    var onlineService = MockOnlineService()
    
    func testGetDataOnline() throws {
        // When
        networkMonitor.isConnected = true
        let appDataServiceProvider = AppDataServiceProvider(networkMonitor: networkMonitor, online: onlineService, offliene: offlineService)
        let expectation = expectation(description: "Got Planet list")
        
        // if
        appDataServiceProvider.getPlanetList { planetList, error in
            // Then
            
            XCTAssertEqual(planetList!.results.count, 2)
            XCTAssertEqual(planetList!.results[0].name, "OnlinePlanet")
            expectation.fulfill()
        }
        waitForExpectations(timeout: 2)

    }
    
    func testGetDataOffline() throws {
        // When
        networkMonitor.isConnected = false
        let appDataServiceProvider = AppDataServiceProvider(networkMonitor: networkMonitor, online: onlineService, offliene: offlineService)
        let expectation = expectation(description: "Got Planet list")
        
        // if
        appDataServiceProvider.getPlanetList { planetList, error in
            // Then
            
            XCTAssertEqual(planetList!.results.count, 1)
            XCTAssertEqual(planetList!.results[0].name, "OfflinePlanet")
            expectation.fulfill()
        }
        waitForExpectations(timeout: 2)

    }
}
