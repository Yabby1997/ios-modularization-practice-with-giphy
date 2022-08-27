//
//  GiphySearchCollectionViewCell.swift
//  GiphySearchPresentationLayer
//
//  Created by USER on 2022/08/27.
//

import UIKit

import SnapKit
import Kingfisher

final class GiphySearchCollectionViewCell: UICollectionViewCell {
    static let identifier = #file

    private let imageView = AnimatedImageView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        imageView.image = nil
    }

    var imageUrl: URL? {
        didSet {
            guard let url = imageUrl else { return }
            imageView.kf.setImage(with: url)
        }
    }

    private func setupViews() {
        contentView.addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
