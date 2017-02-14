//
//  UserCell.swift
//  TableView
//
//  Created by Prearo, Andrea on 8/10/16.
//  Copyright © 2016 Prearo, Andrea. All rights reserved.
//

import UIKit

class UserCell: UITableViewCell {
    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var role: UILabel!

    fileprivate static let defaultAvatar = UIImage(named: "Avatar")

    fileprivate var downloadTask: URLSessionDataTask?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setOpaqueBackground()
        avatar.setRoundedImage(UserCell.defaultAvatar)
    }
  
    func configure(_ viewModel: UserViewModel) {
        downloadTask = avatar.downloadImageFromUrl(viewModel.avatarUrl) { [weak self] (image) in
            guard let strongSelf = self else {
                return
            }
            guard let image = image else {
                strongSelf.avatar.setRoundedImage(UserCell.defaultAvatar)
                return
            }
            strongSelf.avatar.setRoundedImage(image)
        }
        username.text = viewModel.username
        role.text = viewModel.roleText

        isUserInteractionEnabled = false  // Cell selection is not required for this sample
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        downloadTask?.cancel()
        avatar.setRoundedImage(UserCell.defaultAvatar)
    }
}

private extension UserCell {
    static let defaultBackgroundColor = UIColor.groupTableViewBackground

    func setOpaqueBackground() {
        alpha = 1.0
        backgroundColor = UserCell.defaultBackgroundColor
        avatar.alpha = 1.0
        avatar.backgroundColor = UserCell.defaultBackgroundColor
    }
}