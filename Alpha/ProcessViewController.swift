//
//  RootViewController.swift
//  Alpha
//
//  Created by Cristian Monterroza on 12/7/14.
//  Copyright (c) 2014 wrkstrm. All rights reserved.
//

import UIKit

class ProcessViewController : UITableViewController, PHPhotoLibraryChangeObserver {
    //MARK:- Properties
    var collectionsFetchResults = [PHFetchResult]()
    var collectionsLocalizedTitles = [String]()
    
    //MARK:- Constants
    let AllPhotosReuseIdentifier = "AllPhotosCell"
    let CollectionCellReuseIdentifier = "CollectionCell"
    let AllPhotosSegue = "showAllPhotos"
    let CollectionSegue = "showCollection"
    
    //MARK:- View Lifecycle
    override func awakeFromNib() {
        var smartAlbums = PHAssetCollection.fetchAssetCollectionsWithType(PHAssetCollectionType.SmartAlbum, subtype: PHAssetCollectionSubtype.AlbumRegular, options: nil)
        var topLevelUserCollections = PHCollectionList.fetchTopLevelUserCollectionsWithOptions(nil)
        collectionsFetchResults = [smartAlbums, topLevelUserCollections]
        collectionsLocalizedTitles = ["Smart Albums", "Albums"]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool) {
        PHPhotoLibrary.sharedPhotoLibrary().registerChangeObserver(self)
    }
    
    override func viewWillDisappear(animated: Bool) {
        PHPhotoLibrary.sharedPhotoLibrary().unregisterChangeObserver(self)
    }
    
    //MARK: TableView Delegate - Sections
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1 + self.collectionsFetchResults.count
    }
    
    override func tableView(tableView: UITableView, heightForHeaderInSection
        section: Int) -> CGFloat {
            return section == 0 ? 0.0 : 44.00
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return section == 0 ? nil : collectionsLocalizedTitles[section - 1]
    }
    
    //MARK: TableView Delegate - Rows
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? 1 : self.collectionsFetchResults[section - 1].count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath
        indexPath: NSIndexPath) -> UITableViewCell {
            var cell:UITableViewCell
            var localizedTitle:String
            switch indexPath.section {
            case 0:
                cell = tableView.dequeueReusableCellWithIdentifier(AllPhotosReuseIdentifier,
                    forIndexPath: indexPath) as UITableViewCell
                localizedTitle = "All Photos"
            default:
                cell = tableView.dequeueReusableCellWithIdentifier(CollectionCellReuseIdentifier,
                    forIndexPath: indexPath) as UITableViewCell
                var fetchResult = self.collectionsFetchResults[indexPath.section - 1]
                    as PHFetchResult
                var collection = fetchResult[indexPath.row] as PHCollection
                localizedTitle = collection.localizedTitle;
            }
            
            cell.textLabel?.text = localizedTitle;
            return cell
    }
    
    override func tableView(tableView: UITableView, willDisplayCell
        cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
            cell.backgroundColor = UIColor.blackColor()
            cell.textLabel?.textColor = AppDelegate.sobrrGold()
            cell.accessoryView?.tintColor = AppDelegate.sobrrGold()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let controller = segue.destinationViewController as PhotoGridViewController
        switch segue.identifier as String! {
        case "showAllPhotos":
            var options = PHFetchOptions()
            options.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: true)]
            controller.assetsFetchResults = PHAsset.fetchAssetsWithOptions(options)
        default:
            var path = self.tableView.indexPathForCell(sender as UITableViewCell)
            var fetchResult = self.collectionsFetchResults[path!.section - 1]
            if  fetchResult[path!.row] is PHAssetCollection {
                let assetCollection = fetchResult[path!.row] as PHAssetCollection
                var assetsFetchReult = PHAsset.fetchAssetsInAssetCollection(assetCollection,
                    options: nil)
                controller.assetsFetchResults = assetsFetchReult
                controller.assetCollection = assetCollection
            }
        }
    }
    
    //MARK:- PhotoChangeObserver
    func photoLibraryDidChange(changeInstance: PHChange!) {
        dispatch_async(dispatch_get_main_queue()) {
            var updatedCollectionsFetchResults:[PHFetchResult]?
            for collectionsFetchResult in self.collectionsFetchResults as [PHFetchResult] {
                if let changeDetails = changeInstance.changeDetailsForFetchResult(collectionsFetchResult) {
                    if updatedCollectionsFetchResults == nil {
                        updatedCollectionsFetchResults = self.collectionsFetchResults;
                    }
                    if let index = find(self.collectionsFetchResults,collectionsFetchResult) {
                        updatedCollectionsFetchResults![index] = changeDetails.fetchResultAfterChanges
                    }
                }
            }
            
            if updatedCollectionsFetchResults != nil {
                self.collectionsFetchResults = updatedCollectionsFetchResults!
                self.tableView.reloadData()
            }
        }
    }
    
    //MARK:- Transitions.
    
    //MARK:- Memory Management and Dealloc
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
