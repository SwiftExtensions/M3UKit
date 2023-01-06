//
//  SamplePlaylist.swift
//  M3UKitTests
//
//  Created by Александр Алгашев on 05.01.2023.
//

@testable import M3UKit

struct SamplePlaylist {
    static let demo: [M3UItemRepresentable] = [
        M3UHeader(),
        M3UItem(values: [
            "runtime" : "-1",
            "title" : "=== Обновлён: 30.12.2021 === smarttvnews.ru ===",
            "resource" : "https://smarttvnews.ru/wp-content/uploads/2018/11/BT-2016-logo_color7890.png"
        ]),
        M3UItem(values: [
            "runtime" : "-1",
            "title" : "Ultra HD Cinema 4K UHD",
            "group" : "Кино",
            "resource" : "http://zabava-htlive.cdn.ngenix.net/hls/CH_ULTRAHDCINEMA_HLS/bw20000000/variant.m3u8?version=2"
        ]),
        M3UItem(values: [
            "runtime" : "-1",
            "title" : "ULTRA REX 4K UHD",
            "group" : "Кино",
            "resource" : "https://zabava-htlive.cdn.ngenix.net/hls/CH_RUSSIANEXTREMEULTRA_HLS/bw20000000/variant.m3u8?version=2"
        ])
    ]
    static let demoWithCustomKeys: [M3UItemRepresentable] = [
        M3UHeader(),
        M3UItem(values: [
            "runtime" : "-1",
            "title" : "=== Обновлён: 30.12.2021 === smarttvnews.ru ===",
            "resource" : "https://smarttvnews.ru/wp-content/uploads/2018/11/BT-2016-logo_color7890.png"
        ]),
        M3UItem(values: [
            "runtime" : "-1",
            "group_id" : "1",
            "group-title" : "Группа1",
            "tvg-name" : "Ultra HD Cinema 4K UHD",
            "tvg-logo" : "http://site.domain/channel1_logo.png",
            "title" : "Ultra HD Cinema 4K UHD",
            "group" : "Кино",
            "resource" : "http://zabava-htlive.cdn.ngenix.net/hls/CH_ULTRAHDCINEMA_HLS/bw20000000/variant.m3u8?version=2"
        ]),
        M3UItem(values: [
            "runtime" : "-1",
            "title" : "ULTRA REX 4K UHD",
            "group" : "Кино",
            "resource" : "https://zabava-htlive.cdn.ngenix.net/hls/CH_RUSSIANEXTREMEULTRA_HLS/bw20000000/variant.m3u8?version=2"
        ])
    ]
    
    
}
