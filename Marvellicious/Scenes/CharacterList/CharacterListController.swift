//
//  CharacterListController.swift
//  Marvellicious
//
//  Created by Mert Gürcan on 20.02.2022.
//

import Foundation
import UIKit

class CharacterListController : UIViewController {

    let CELL_IDENTIFIER = "cellIdentifier"

    lazy var tableView : UITableView = {
        let tv = UITableView()
        tv.delegate = self
        tv.dataSource = self
        tv.backgroundColor = .white
        tv.register(CharacterListTableViewCell.self, forCellReuseIdentifier: CELL_IDENTIFIER)
        return tv
    }()

    var numberOfPage : Int = 1
    var list : [CharacterListPresentation]?
    var stop : Bool = true

    var viewModel : CharacterListViewModelProtocol! {
        didSet {
            viewModel.delegate = self
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        viewModel.getCharacters(page: numberOfPage)
    }

    func setupView() {
        self.navigationController?.navigationBar.tintColor = .white
        view.backgroundColor = .white
        view.addSubview(tableView)
        tableView.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.safeAreaLayoutGuide.leftAnchor, bot: view.safeAreaLayoutGuide.bottomAnchor, right: view.safeAreaLayoutGuide.rightAnchor, topConstant: 0, leftConstant: 0, botConstant: 0, rightConstant: 0, width: 0, height: 0)
    }
}

extension CharacterListController: CharacterListViewModelDelegate {
    func handleOutput(_ output: CharacterListViewModelOutput) {
        switch output {
        case .updateList(let presentation):
            if numberOfPage == 1 {
                self.list = presentation
            } else {
                self.list?.append(contentsOf: presentation)
            }
            DispatchQueue.main.async {
                self.stop = false
                self.tableView.reloadData()
            }
        }
    }
}

// MARK: TableViewDelegate
extension CharacterListController :  UITableViewDelegate, UIScrollViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(100)
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.goCharacterDetails(index: indexPath.row)
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let position = scrollView.contentOffset.y
        if position > tableView.contentSize.height - 100 - scrollView.frame.size.height{

            if stop == false {
                stop = true
                numberOfPage += 1
                viewModel.getCharacters(page: numberOfPage)
            }

        }
    }
}

// MARK: TableViewDataSource
extension CharacterListController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CELL_IDENTIFIER, for: indexPath) as! CharacterListTableViewCell
        cell.result = list?[indexPath.row]
        cell.selectionStyle = .none
        return cell
    }
}
