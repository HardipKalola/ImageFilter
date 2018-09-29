//
//  ViewController.swift
//  FilterDemo
//
//  Created by Hardip Kalola on 29/09/18.
//  Copyright © 2018 Hardip Kalola. All rights reserved.
//

import UIKit
class VideoEditOptionsCollCell: UICollectionViewCell {
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var imgFilter: UIImageView!
    @IBOutlet weak var lblFilterName: UILabel!
    @IBOutlet weak var isFilterSelected: UIImageView!
}

class ViewController: UIViewController {

    @IBOutlet weak var imgView: UIImageView!
    var context: CIContext?
    var imgVideo: UIImage?
    var imgFilters: ImageCIFilters!
    @IBOutlet weak var collViewFilters: UICollectionView!

    private var arrFilterNames = ["NORMAL", "INSTANT", "FADE", "NOIR", "TRANSFER", "CHROME", "TONAL", "PROCESS", "VIGNETTE", "POSTERIZE", "BLACK & WHITE", "LINEAR"]

    override func viewDidLoad() {
        super.viewDidLoad()
        imgVideo = self.imgView.image
        context = CIContext(options: nil)
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrFilterNames.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: VideoEditOptionsCollCell = collectionView.dequeueReusableCell(withReuseIdentifier: "videofilterscell", for: indexPath) as! VideoEditOptionsCollCell
        configureImgVideoCell(cell, indexPath)
        return cell
    }
    
    func configureImgVideoCell(_ cell: VideoEditOptionsCollCell, _ indexPath: IndexPath) {
        if indexPath.row == 0 {
            cell.lblFilterName.text = arrFilterNames[indexPath.row]
            cell.imgFilter.image = imgVideo
        } else {
            //Load Filter
            cell.lblFilterName.text = arrFilterNames[indexPath.row]
            if let imgVideo = imgVideo {
                imgFilters = ImageCIFilters(filterType: ImageFilterType(rawValue: indexPath.row - 1)!)
                imgFilters.inputImage = CIImage(image: imgVideo)
                if let outputImage = imgFilters.outputFilteredImage(), let filteredImage = context?.createCGImage(outputImage, from: outputImage.extent) {
                    cell.imgFilter.image = UIImage(cgImage: filteredImage)
                }
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //Live Filters Selection
        if indexPath.row == 0 {
        } else {
            var filter = ImageCIFilters(filterType: ImageFilterType(rawValue: indexPath.row - 1)!)
            filter.inputImage = CIImage(image:imgVideo!)

            if let outputImage = filter.outputFilteredImage(),
                let filteredImage = context?.createCGImage(outputImage, from: outputImage.extent) {
                self.imgView.image = UIImage(cgImage: filteredImage)
            }
        }
//        collectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width / 3.25, height: collectionView.bounds.height)
    }
}

