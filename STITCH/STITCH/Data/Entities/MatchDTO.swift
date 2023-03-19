//
//  MatchDTO.swift
//  STITCH
//
//  Created by neuli on 2023/03/19.
//

import Foundation

struct MatchDTO: Codable {
    let id: String
    let type: String
    let location: String
    let imageUrl: String
    let name: String
    let detail: String
    let startTime: String
    let duration: Int
    let eventType: String
    let hostId: String
    let maxCapacity: Int
    let fee: Int
    let latitude: String
    let longitude: String
    let teach: Bool
    let numOfMembers: Int
    
    init(
        id: String,
        type: String = "match",
        location: String,
        imageUrl: String,
        name: String,
        detail: String,
        startTime: String,
        duration: Int,
        eventType: String,
        hostId: String,
        maxCapacity: Int,
        fee: Int,
        latitude: String,
        longitude: String,
        teach: Bool,
        numOfMembers: Int = 1
    ) {
        self.id = id
        self.type = type
        self.location = location
        self.imageUrl = imageUrl
        self.name = name
        self.detail = detail
        self.startTime = startTime
        self.duration = duration
        self.eventType = eventType
        self.hostId = hostId
        self.maxCapacity = maxCapacity
        self.fee = fee
        self.latitude = latitude
        self.longitude = longitude
        self.teach = teach
        self.numOfMembers = numOfMembers
    }
    
    init(match: Match) {
        self.id = match.matchID
        self.type = "match"
        self.location = match.locationInfo.address
        self.imageUrl = match.matchImageURL
        self.name = match.matchTitle
        self.detail = match.content
        self.startTime = match.startDate.addTime(hour: match.startHour, minute: match.startMinute).toString()
        self.duration = match.duration
        self.eventType = match.sport.name
        self.hostId = match.matchHostID
        self.maxCapacity = match.maxHeadCount
        self.fee = match.fee
        self.latitude = match.locationInfo.latitude ?? ""
        self.longitude = match.locationInfo.longitude ?? ""
        self.teach = match.matchType.isTeach
        self.numOfMembers = match.headCount
    }
}
