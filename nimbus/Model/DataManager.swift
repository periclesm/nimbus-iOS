//
//  DataManager.swift
//  nimbus
//
//  Created by Pericles Maravelakis on 29/12/20.
//	periclesm@cloudfields.net
//	Licensed under Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)
//	https://creativecommons.org/licenses/by-sa/4.0/
//

import Foundation

class DataManager: NSObject {

	//MARK: - Prefetch Classes --

	class func prefetchData(completion: @escaping (Bool) -> ()) {
		self.getCombinedData({(completed) in
			completion(completed)
		})
	}

	//MARK: - Get Data Classes --

	class func getCombinedData(_ completion: ((Bool) -> Void)? = nil) {
		let headers = DataAPI.getDefaultHeaders()
		let config = NetConfig.initWithConfig(requestURL: DataAPI.combinedDataURL, requestHeaders: headers, requestMethod: .GET)

		Networker.getJSONData(config: config) { (response) in
			if response.completed {
				let data = response.data as! Dictionary<AnyHashable,Any>
				DataMapHelper.mapCloudData(data: data)
				completion?(true)
				debugPrint("Fetch All Data complete")
			}
			else {
				debugPrint(response.error?.localizedDescription ?? "error")
				completion?(false)
			}
		}
	}

	class func getAltitudeData(_ completion: ((Bool) -> Void)? = nil) {
		let headers = DataAPI.getDefaultHeaders()
		let config = NetConfig.initWithConfig(requestURL: DataAPI.clAltitudeURL, requestHeaders: headers, requestMethod: .GET)

		Networker.getJSONData(config: config) { (response) in
			if response.completed {
				let data = response.data as! Dictionary<AnyHashable,Any>
				DataMapHelper.mapAltitudeData(data: data)
				completion?(true)
				debugPrint("Fetch Type Data complete")
			}
			else {
				debugPrint(response.error?.localizedDescription ?? "error")
				completion?(false)
			}
		}
	}

	class func getDetailData(_ completion: ((Bool) -> Void)? = nil) {
		let headers = DataAPI.getDefaultHeaders()
		let config = NetConfig.initWithConfig(requestURL: DataAPI.clDetailURL, requestHeaders: headers, requestMethod: .GET)

		Networker.getJSONData(config: config) { (response) in
			if response.completed {
				let data = response.data as! Dictionary<AnyHashable,Any>
				DataMapHelper.mapDetailData(data: data)
				completion?(true)
				debugPrint("Fetch Detail Data complete")
			}
			else {
				debugPrint(response.error?.localizedDescription ?? "error")
				completion?(false)
			}
		}
	}

	class func getCloudData(_ completion: ((Bool) -> Void)? = nil) {
		let headers = DataAPI.getDefaultHeaders()
		let config = NetConfig.initWithConfig(requestURL: DataAPI.cloudURL, requestHeaders: headers, requestMethod: .GET)

		Networker.getJSONData(config: config) { (response) in
			if response.completed {
				let data = response.data as! Dictionary<AnyHashable,Any>
				DataMapHelper.mapCloudData(data: data)
				completion?(true)
				debugPrint("Fetch List Data complete")
			}
			else {
				debugPrint(response.error?.localizedDescription ?? "error")
				completion?(false)
			}
		}
	}
}
