//
//  GameVC.swift
//  hack2
//
//  Created by yojkim on 2017. 3. 4..
//  Copyright © 2017년 MashUp. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

struct GamePhotoData {
    var isSelected: Bool = false
    var gamePhotoUrl: URL!
}

enum StageType {
    case Hand, Ear, PreciousThing, Letter
}

class GameVC: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {
    
    @IBOutlet weak var photoCollectionView: UICollectionView!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    public var gameId: Int?
    
    var gamePhotoDataArray: [GamePhotoData] = []

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.defaultUISetting()
        
    }
    
    func defaultUISetting() {
        
        self.photoCollectionView.dataSource = self
        self.photoCollectionView.delegate = self
        
        self.resetUISetting()
        
    }
    
    func resetUISetting() {
        
        self.photoCollectionView.reloadData()
        
    }

    
    func configure(_ gamePhotoCell: GamePhotoCell, indexPath: IndexPath) -> GamePhotoCell {
        
        let currentGamePhotoData: GamePhotoData = self.gamePhotoDataArray[indexPath.row]
        
        Alamofire.request(currentGamePhotoData.gamePhotoUrl).responseImage { (response) in
            if let image = response.result.value {
                gamePhotoCell.imageView.image = image
            }
        }
        
        return gamePhotoCell
        
    }
    
    func requestGameInfo(gameId gameId:Int, gameStage:StageType) {
        
        var urlString = "http://192.168.0.25:8080/api/games"
        urlString.append("/\(gameId)")
        
        switch gameStage {
        case .Hand:
            urlString.append("/HAND")
            break
        case .Ear:
            urlString.append("/EAR")
            break
        case .PreciousThing:
            urlString.append("/FREQUENTLY_USE_ITEM")
            break
        case .Letter:
            urlString.append("/SCRIPT")
            break
        default: break
        }
        
//        if let url = URL(string: urlString) {
//            Alamofire.request(url).responseJSON(completionHandler: { (response) in
//                
//            })
//        }
    }
    
    // MARK: - UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 12
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let cell = photoCollectionView.dequeueReusableCell(withReuseIdentifier: "photoCell",
                                                              for: indexPath) as? GamePhotoCell {
            
//            return self.configure(cell, indexPath: indexPath)
            cell.imageView.image = UIImage(named: "\(indexPath.row)")
            
            return cell
            
        } else {
            
            return GamePhotoCell();
            
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        switch UIScreen.main.bounds.size.height {
        case (0...568):
            return CGSize(width: 130.0, height: 130.0)
        case (569...667):
            return CGSize(width: 160.0, height: 160.0)
        case (668...736):
            return CGSize(width: 180.0, height: 180.0)
        default:
            return CGSize(width: 180.0, height: 180.0)
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "photoCell", for: indexPath) as? GamePhotoCell {
            var currentGamePhotoData: GamePhotoData = self.gamePhotoDataArray[indexPath.row]
            
            currentGamePhotoData.isSelected = !currentGamePhotoData.isSelected
            
            if (currentGamePhotoData.isSelected) {
                cell.checkButton.setImage(UIImage(named: "photoWhiteOval"), for: UIControlState.normal)
            } else {
                cell.checkButton.setImage(UIImage(named: "photoChecked"), for: UIControlState.normal)
            }
        }
    }
    
    @IBAction func gameExitButtonPressed(_ sender: Any) {
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func completeButtonPressed(_ sender: Any) {
        let gameResultWaitingVC = UIStoryboard(name: "GameResultWaitingVC", bundle: nil).instantiateViewController(withIdentifier: "GameResultWaitingVC")
        
        self.navigationController?.pushViewController(gameResultWaitingVC, animated: true)
        
        
    }
    
}
