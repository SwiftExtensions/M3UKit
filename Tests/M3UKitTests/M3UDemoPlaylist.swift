//
//  M3UDemoPlaylist.swift
//
//
//  Created by Александр Алгашев on 07.02.2022.
//

import Foundation
@testable import M3UKit

struct M3UDemoPlaylist {
    static let linesExample: [M3UPlaylistLine] = [
        .extM3U,
        .extInf(runtime: -1, title: "=== Обновлён: 30.12.2021 === smarttvnews.ru ==="),
        .resource(path: "https://smarttvnews.ru/wp-content/uploads/2018/11/BT-2016-logo_color7890.png"),
        .extInf(runtime: -1, title: "Ultra HD Cinema 4K UHD"),
        .extGrp(group: "Кино"),
        .resource(path: "http://zabava-htlive.cdn.ngenix.net/hls/CH_ULTRAHDCINEMA_HLS/bw20000000/variant.m3u8?version=2"),
        .extInf(runtime: -1, title: "ULTRA REX 4K UHD"),
        .extGrp(group: "Кино"),
        .resource(path: "https://zabava-htlive.cdn.ngenix.net/hls/CH_RUSSIANEXTREMEULTRA_HLS/bw20000000/variant.m3u8?version=2")
    ]
    
    static let linesInvalidTagExample: [M3UPlaylistLine] = [
        .extM3U,
        .extInf(runtime: -1, title: "=== Обновлён: 30.12.2021 === smarttvnews.ru ==="),
        .resource(path: "https://smarttvnews.ru/wp-content/uploads/2018/11/BT-2016-logo_color7890.png"),
        .extInf(runtime: -1, title: "Ultra HD Cinema 4K UHD"),
        .extGrp(group: "Кино"),
        .resource(path: "http://zabava-htlive.cdn.ngenix.net/hls/CH_ULTRAHDCINEMA_HLS/bw20000000/variant.m3u8?version=2"),
        .extInf(runtime: -1, title: "ULTRA REX 4K UHD"),
        .extGrp(group: "Кино"),
        .unknownTag(name: "#EXTVLCOPT:", value: "http-user-agent=OnlineTvAppDroid"),
        .resource(path: "https://zabava-htlive.cdn.ngenix.net/hls/CH_RUSSIANEXTREMEULTRA_HLS/bw20000000/variant.m3u8?version=2")
    ]
    
    static let itemsExample: [M3UPlaylistItem] = [
        M3UPlaylistItem(
            runtime: -1,
            title: "=== Обновлён: 30.12.2021 === smarttvnews.ru ===",
            group: nil,
            resource: .url(URL(string: "https://smarttvnews.ru/wp-content/uploads/2018/11/BT-2016-logo_color7890.png")!)),
        M3UPlaylistItem(
            runtime: -1,
            title: "Ultra HD Cinema 4K UHD",
            group: "Кино",
            resource: .url(URL(string: "http://zabava-htlive.cdn.ngenix.net/hls/CH_ULTRAHDCINEMA_HLS/bw20000000/variant.m3u8?version=2")!)),
        M3UPlaylistItem(
            runtime: -1,
            title: "ULTRA REX 4K UHD",
            group: "Кино",
            resource: .url(URL(string: "https://zabava-htlive.cdn.ngenix.net/hls/CH_RUSSIANEXTREMEULTRA_HLS/bw20000000/variant.m3u8?version=2")!))
    ]
    
    
}
