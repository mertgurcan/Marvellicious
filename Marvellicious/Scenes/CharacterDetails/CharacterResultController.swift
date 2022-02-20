//
//  CharacterResultController.swift
//  Marvellicious
//
//  Created by Mert Gürcan on 20.02.2022.
//

import Foundation
import UIKit

class CharacterResultController : UIViewController {

    let CELL_IDENTIFIER = "cellIdentifier"

    var details: CharacterDetailsPresentation? {
        didSet {
            guard let details = details else {
                return
            }
            ImageDownloader.downloaded(from: details.photo) { image in
                self.heroImage.image = image
            }
            heroNameLabel.text = details.name
            heroDetailsLabel.text = details.characterDescription.isEmpty ? "No description": details.characterDescription
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }

    var heroNameLabel : UILabel = {
        var l = UILabel()
        l.textColor = .black
        l.textAlignment = .center
        return l
    }()

    var heroDetailsLabel : UILabel = {
        var l = UILabel()
        l.numberOfLines = 0
        l.textColor = .black
        return l
    }()

    var heroImage : UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        return iv
    }()

    lazy var tableView : UITableView = {
        let tv = UITableView()
        tv.delegate = self
        tv.dataSource = self
        tv.backgroundColor = .white
        tv.register(UITableViewCell.self, forCellReuseIdentifier: CELL_IDENTIFIER)
        return tv
    }()

    var viewModel : CharacterDetailsViewModelProtocol! {
        didSet {
            viewModel.delegate = self
        }
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.start()
        setupView()
    }

    func setupView() {
        view.backgroundColor = .white
        view.addSubview(heroNameLabel)
        heroNameLabel.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.safeAreaLayoutGuide.leftAnchor, bot: nil, right: view.safeAreaLayoutGuide.rightAnchor, topConstant: 10, leftConstant: 10, botConstant: 0, rightConstant: 10, width: 0, height: 40)

        view.addSubview(heroImage)
        heroImage.anchor(top: heroNameLabel.bottomAnchor, left: view.safeAreaLayoutGuide.leftAnchor, bot: nil, right: view.safeAreaLayoutGuide.rightAnchor, topConstant: 10, leftConstant: 0, botConstant: 0, rightConstant: 0, width: 0, height: 200)

        view.addSubview(heroDetailsLabel)
        heroDetailsLabel.anchor(top: heroImage.bottomAnchor, left: view.safeAreaLayoutGuide.leftAnchor, bot: nil, right: view.safeAreaLayoutGuide.rightAnchor, topConstant: 10, leftConstant: 10, botConstant: 0, rightConstant: 10, width: 0, height: 150)

        view.addSubview(tableView)
        tableView.anchor(top: heroDetailsLabel.bottomAnchor, left: view.safeAreaLayoutGuide.leftAnchor, bot: view.safeAreaLayoutGuide.bottomAnchor, right: view.safeAreaLayoutGuide.rightAnchor, topConstant: 10, leftConstant: 0, botConstant: 0, rightConstant: 0, width: 0, height: 0)
    }
}

extension CharacterResultController : CharacterDetailsViewModelDelegate {
    func handleOutput(_ output: CharacterDetailsViewModelOutput) {
        switch output {
        case .showDetails(let details):
            self.details = details
        }
    }
}
extension CharacterResultController : UITableViewDelegate {

}

extension CharacterResultController : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (details?.comicslist.count)! > 10 {
            return 10
        } else {
            return (details?.comicslist.count)!
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CELL_IDENTIFIER, for: indexPath)
        cell.textLabel?.text = details?.comicslist[indexPath.row].name
        cell.textLabel?.textColor = .black
        cell.backgroundColor = .white
        cell.selectionStyle = .none
        return cell
    }


}
