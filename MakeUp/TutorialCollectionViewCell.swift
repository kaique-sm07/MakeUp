//
//  TutorialCollectionViewCell.swift
//  MakeUp
//
//  Created by Lucas Moreton on 6/16/16.
//  Copyright © 2016 Kaique de Souza Monteiro. All rights reserved.
//

import UIKit

class TutorialCollectionViewCell: UICollectionViewCell{
    
    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var playButton: UIButton!
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        self.commonInit()
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
    }
    
    private func commonInit()
    {
        // Initialization code
        
        self.layoutIfNeeded()
        self.layoutSubviews()
        self.setNeedsDisplay()
    }
    
    override func didUpdateFocusInContext(context: UIFocusUpdateContext, withAnimationCoordinator coordinator: UIFocusAnimationCoordinator) {
        if (self.focused)
        {
            self.thumbnailImageView.adjustsImageWhenAncestorFocused = true
        }
        else
        {
            self.thumbnailImageView.adjustsImageWhenAncestorFocused = false
        }
    }
    
    override func layoutSubviews()
    {
        super.layoutSubviews()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
}
