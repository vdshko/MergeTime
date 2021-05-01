//
//  RoadViewController.swift
//  MergeTime
//
//  Created by Vlad Shkodich on 02.05.2021.
//

import UI

final class RoadViewController: ViewController<RoadView> {
    
    private let viewModel: RoadViewModel
    
    init(viewModel: RoadViewModel) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }
}
