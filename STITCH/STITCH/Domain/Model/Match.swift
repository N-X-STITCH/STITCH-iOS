//
//  Match.swift
//  STITCH
//
//  Created by neuli on 2023/03/02.
//

import Foundation

struct Match: Codable, Hashable {
    var matchID: String
    var matchHostID: String
    var matchTitle: String
    var matchImageURL: String
    var locationInfo: LocationInfo
    var content: String
    var matchType: MatchType
    var sport: Sport
    var startDate: Date
    var startHour: Int
    var startMinute: Int
    var duration: Int
    var headCount: Int
    var maxHeadCount: Int
    var fee: Int
    
    init() {
        self.matchID = UUID().uuidString
        self.matchHostID = ""
        self.matchTitle = ""
        self.matchImageURL = ""
        self.locationInfo = LocationInfo(address: "")
        self.content = ""
        self.matchType = .match
        self.sport = .all
        self.startDate = Date()
        self.startHour = 0
        self.startMinute = 0
        self.duration = 0
        self.headCount = 0
        self.maxHeadCount = 0
        self.fee = 0
    }
    
    init(
        matchID: String,
        hostID: String,
        matchTitle: String,
        matchImageURL: String,
        locationInfo: LocationInfo,
        content: String,
        matchType: MatchType,
        sport: Sport,
        startDate: Date,
        startHour: Int,
        startMinute: Int,
        duration: Int,
        headCount: Int = 1,
        maxHeadCount: Int,
        fee: Int = 0
    ) {
        self.matchID = matchID
        self.matchHostID = hostID
        self.matchTitle = matchTitle
        self.matchImageURL = matchImageURL
        self.locationInfo = locationInfo
        self.content = content
        self.matchType = matchType
        self.sport = sport
        self.startDate = startDate
        self.startHour = startHour
        self.startMinute = startMinute
        self.duration = duration
        self.headCount = headCount
        self.maxHeadCount = maxHeadCount
        self.fee = fee
    }
    
    init(matchDTO: MatchDTO) {
        let location = LocationInfo(
            address: matchDTO.location,
            latitude: matchDTO.latitude,
            longitude: matchDTO.longitude
        )
        self.matchID = matchDTO.id
        self.matchHostID = matchDTO.hostId
        self.matchTitle = matchDTO.name
        self.matchImageURL = matchDTO.imageUrl
        self.locationInfo = location
        self.content = matchDTO.detail
        self.matchType = MatchType(matchDTO.teach)
        self.sport = Sport(matchDTO.eventType)!
        self.startDate = matchDTO.startTime.toDate()
        self.startHour = startDate.hour()
        self.startMinute = startDate.minute()
        self.duration = matchDTO.duration
        self.headCount = matchDTO.numOfMembers
        self.maxHeadCount = matchDTO.maxCapacity
        self.fee = matchDTO.fee
    }
}
