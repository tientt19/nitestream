//
//  MainPresenter.swift
//  ChuaTeHoiDongQuanTri
//
//  Created by Valerian on 20/02/2022.
//

import Foundation


protocol UpdateMainDelegate {
    func updateUI()
}

class MainPresenter {
    var delegate : UpdateMainDelegate!
    var listData = [MainModel]()
    
    private var workItemFetchData : DispatchWorkItem?
    private let queue = DispatchQueue(label: "com.tien.loadDataQueue")
    
    init(view : UpdateMainDelegate) {
        delegate = view
    }
    
    // get data from API
    func getData(page : Int) {
        
        workItemFetchData?.cancel()
        let dispatchGroup = DispatchGroup()

        var newWorkItemFetchData: DispatchWorkItem? = nil
        
        newWorkItemFetchData = DispatchWorkItem { [weak self] in
            guard let _self = self else { return }
            if newWorkItemFetchData?.isCancelled == true {
                _self.listData = []
                dLogDebug("work item cancel!")
                return
            }
        }
        ///enter to get place data
        dispatchGroup.enter()
        
        APIService.shared.getPlaceData(numberOfPage: page) { [weak self] response, error in
            
            guard let _self = self else { return }
            
            if newWorkItemFetchData?.isCancelled == true {
                _self.listData = []
                dLogDebug("internal new work item cancel!")
                dispatchGroup.leave()
                return
            }
            
            if let data = response {
                _self.listData = data
                dispatchGroup.leave()
            }
            
        }
        
        /// notify when work item done
        newWorkItemFetchData?.notify(queue: queue) {
            dispatchGroup.wait()
            self.delegate.updateUI()
        }
        
        /// execute work item at background
         queue.async(execute: newWorkItemFetchData!)
         workItemFetchData = newWorkItemFetchData
    }
    
    func getListPhoto() -> [MainModel] {
        return listData
    }
}
