//
//  UICollectionView+Extensions.swift
//  UIKit+Extensions
//
//  Created by USER on 2022/08/27.
//

import UIKit

protocol UICollectionViewReusableView {
    static var identifier: String { get }
}

extension UICollectionViewReusableView {
    static var identifier: String {
        String(describing: self)
    }
}

extension UICollectionViewCell: UICollectionViewReusableView { }
extension UICollectionReusableView: UICollectionViewReusableView { }

public extension UICollectionView {
    func register<Cell: UICollectionViewCell>(cell type: Cell.Type) {
        register(type, forCellWithReuseIdentifier: type.identifier)
    }

    func register<SupplementaryView: UICollectionReusableView>(
        supplementaryView type: SupplementaryView.Type,
        forSupplementaryViewOfKind kind: String
    ) {
        register(type, forSupplementaryViewOfKind: kind, withReuseIdentifier: type.identifier)
    }

    func dequeueReusableCell<Cell: UICollectionViewCell>(
        type: Cell.Type,
        for indexPath: IndexPath
    ) -> Cell {
        guard let cell = dequeueReusableCell(
            withReuseIdentifier: type.identifier,
            for: indexPath
        ) as? Cell else { preconditionFailure("invalid reusable collection view cell") }
        return cell
    }

    func dequeueReusableSupplementaryView<SupplementaryView: UICollectionReusableView>(
        ofKind kind: String,
        type: SupplementaryView.Type,
        for indexPath: IndexPath
    ) -> SupplementaryView {
        guard let supplementaryView = dequeueReusableSupplementaryView(
            ofKind: kind,
            withReuseIdentifier: type.identifier,
            for: indexPath
        ) as? SupplementaryView else { preconditionFailure("invalid reusable collection supplementary view") }
        return supplementaryView
    }
}
