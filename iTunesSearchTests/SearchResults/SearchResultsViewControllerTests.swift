//
//  SearchResultsViewControllerTests.swift
//  iTunesSearchTests
//
//  Created by Ryan on 4/23/20.
//  Copyright © 2020 Ryan. All rights reserved.
//

import XCTest
@testable import iTunesSearch

class SearchResultsViewControllerTests: XCTestCase {
    var sut: SearchResultsViewController!
    
    override func setUp() {
        sut = SearchResultsViewController()
        let viewModel = MockSearchResultsViewModel(searchTerm: "sample", delegate: sut)
        sut.viewModel = viewModel
    }

    override func tearDown() {
        sut = nil
    }

    func testViewDidLoadUpdatesViewModel() {
        // When
        sut.viewDidLoad()
        
        // Then
        XCTAssertEqual(sut.viewModel?.songs.count, 4)
    }
}
