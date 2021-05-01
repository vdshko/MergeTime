//
//  AccountViewController.swift
//  MergeTime
//
//  Created by Vlad Shkodich on 02.05.2021.
//

import UI

final class AccountViewController: ViewController<AccountView> {
    
    private let viewModel: AccountViewModel
    
    init(viewModel: AccountViewModel) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }
}
