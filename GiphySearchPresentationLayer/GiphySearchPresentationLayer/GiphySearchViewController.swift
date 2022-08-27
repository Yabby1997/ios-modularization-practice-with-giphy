//
//  GiphySearchViewController.swift
//  GiphySearchPresentationLayer
//
//  Created by USER on 2022/08/14.
//

import Combine
import UIKit

public final class GiphySearchViewController: UIViewController {

    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(
            GiphySearchCollectionViewCell.self,
            forCellWithReuseIdentifier: GiphySearchCollectionViewCell.identifier
        )
        return collectionView
    }()

    private let viewModel: GiphySearchViewModel
    private var cancellables: Set<AnyCancellable> = []

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
        bindViewModel()
        viewModel.didLoad()
    }

    private func setupViews() {
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        collectionView.delegate = self
        collectionView.dataSource = self
    }

    private func bindViewModel() {
        viewModel.$images
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.collectionView.reloadData()
            }
            .store(in: &cancellables)
    }
}

extension GiphySearchViewController: UICollectionViewDelegateFlowLayout {
    public func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        let width = (view.frame.width - 1.0) / 2
        return CGSize(width: width, height: width)
    }

    public func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumLineSpacingForSectionAt section: Int
    ) -> CGFloat {
        1.0
    }

    public func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumInteritemSpacingForSectionAt section: Int
    ) -> CGFloat {
        1.0
    }
}

extension GiphySearchViewController: UICollectionViewDataSource {
    public func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        viewModel.images.count
    }

    public func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: GiphySearchCollectionViewCell.identifier,
            for: indexPath
        )
        guard let cell = cell as? GiphySearchCollectionViewCell else { return cell }
        let image = viewModel.images[indexPath.item]
        cell.imageUrl = image.thumbnailUrl
        return cell
    }
}
