//
//  StoreroomViewController.swift
//  MergeTime
//
//  Created by Vlad Shkodich on 01.05.2021.
//

import UI

final class StoreroomViewController: ViewController<StoreroomView> {

    private let viewModel: StoreroomViewModel
    
    init(viewModel: StoreroomViewModel) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }
}
