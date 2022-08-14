//
//  GiphySearchViewController.swift
//  GiphySearchPresentationLayer
//
//  Created by USER on 2022/08/14.
//

import UIKit

public final class GiphySearchViewController: UIViewController {

    private let viewModel: GiphySearchViewModel

    public init(viewModel: GiphySearchViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()

        Task {
            let datas = try await viewModel.didLoad()
            print(datas)
        }
    }

    private func setupViews() {
        view.backgroundColor = .red
    }
}
