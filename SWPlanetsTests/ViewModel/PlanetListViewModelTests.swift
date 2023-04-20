//
//  PlanetListViewModelTest.swift
//  SWPlanetsTests
//
//  Created by Rohit Ragmahale on 18/04/2023.
//

import XCTest
@testable import SWPlanets

final class PlanetListViewModelTests: XCTestCase {

    var networkMonitor = MockNetworkMonitor()
    var offlineService = MockOfflineService()
    var onlineService = MockOnlineService()
    var viewModel:PlanetListViewModel?
  
    func testTestOfflineData() throws {
        // When
        networkMonitor.isConnected = false
        let mockAppDataServiceProvider = MockAppDataServiceProvider(online: onlineService, offLine: offlineService)
        mockAppDataServiceProvider.isOnline = false
        viewModel = PlanetListViewModel(serviceProvider: mockAppDataServiceProvider, networkMonitor: networkMonitor)
        let expectation = expectation(description: "Got Planet list")
        
        // if
        viewModel?.viewDidAppear()
        
        // Then
        DispatchQueue.main.asyncAfter(deadline: .now(), execute: DispatchWorkItem(block: {
            XCTAssertEqual(self.viewModel?.planetList.count, 1)
            XCTAssertEqual(self.viewModel?.planetList[0].name, "OfflinePlanet")
            expectation.fulfill()
        }))
        waitForExpectations(timeout: 2)
    }

    func testTestonlineData() throws {
        // When
        networkMonitor.isConnected = true
        let mockAppDataServiceProvider = MockAppDataServiceProvider(online: onlineService, offLine: offlineService)
        mockAppDataServiceProvider.isOnline = true
        viewModel = PlanetListViewModel(serviceProvider: mockAppDataServiceProvider, networkMonitor: networkMonitor)
        let expectation = expectation(description: "Got Planet list")
        
        // if
        viewModel?.viewDidAppear()
        
        // Then
        DispatchQueue.main.asyncAfter(deadline: .now(), execute: DispatchWorkItem(block: {
            XCTAssertEqual(self.viewModel?.planetList.count, 2)
            XCTAssertEqual(self.viewModel?.planetList[0].name, "OnlinePlanet")
            expectation.fulfill()
        }))
        waitForExpectations(timeout: 2)
    }
    

}
