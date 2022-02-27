//
//  Detail.swift
//  nimbus
//
//  Created by Pericles Maravelakis on 28/12/20.
//	periclesm@cloudfields.net
//	Licensed under Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)
//	https://creativecommons.org/licenses/by-sa/4.0/
//

import RealmSwift

class CloudDetail: Object {

	@objc dynamic var objectId: String = ""
	@objc dynamic var detail: String = ""
	@objc dynamic var image: String = ""
	@objc dynamic var wiki: String = ""

	
	//MARK: - DB Properies --

	override static func primaryKey() -> String? {
		return "objectId"
	}

	override static func indexedProperties() -> [String] {
		return ["image", "wiki"]
	}

	override static func ignoredProperties() -> [String] {
		return []
	}


	//MARK: - Map Data --

	class func mapObject(object: Dictionary<AnyHashable,Any>) -> CloudDetail {
		let detailObject = CloudDetail()

		detailObject.objectId = object["objectId"] as? String ?? ""
		detailObject.detail = object["detail"] as? String ?? ""
		detailObject.image = object["image"] as? String ?? ""
		detailObject.wiki = object["wiki"] as? String ?? ""

		return detailObject
	}
}
