//
//  SearchController.swift
//  Weather
//
//  Created by Carlos Chaguendo on 16/03/22.
//

import UIKit

@objc protocol SearchControllerDelegate: AnyObject {
    
    @objc optional func beginEditing(for vc: SearchController)
    @objc optional func endEditing(for vc: SearchController)

    func clearFilter(for vc: SearchController)

    func searchController(_ vc: SearchController, textDidChange searchText: String)

}

/// Personalizar una barra de naviegacion que tenga todo
class SearchController: UISearchController, UISearchBarDelegate {

    private var pendingRequestWorkItem: DispatchWorkItem?
    private weak var updater: SearchControllerDelegate?

    init(delegate: SearchControllerDelegate) {
        super.init(searchResultsController: nil)
        obscuresBackgroundDuringPresentation = false
        hidesNavigationBarDuringPresentation = false
        searchBar.delegate = self
        self.updater = delegate
    }

    @available(*, unavailable, message: "No disponible para creacion por StoryBoard")
    required init?(coder: NSCoder) {
        preconditionFailure()
    }

    // MARK: - Search Bar Delegate

    private func clearFilter() {
        updater?.clearFilter(for: self)
    }

    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        self.updater?.beginEditing?(for: self)
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        self.updater?.endEditing?(for: self)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        /// cancela el actual item si existe
        pendingRequestWorkItem?.cancel()

        if searchText.isEmpty {
            clearFilter()
            return
        }
        
        let requestWorkItem = DispatchWorkItem { [weak self] in
            guard let self = self else { return }
            self.updater?.searchController(self, textDidChange: searchText)
        }

        pendingRequestWorkItem = requestWorkItem
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(100), execute: requestWorkItem)
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        clearFilter()
    }

}
