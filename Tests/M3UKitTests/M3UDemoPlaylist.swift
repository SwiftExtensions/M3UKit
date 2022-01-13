@testable import M3UKit

struct M3UDemoPlaylist {
    static let example = """
#EXTM3U
#EXTINF:-1,=== Обновлён: 30.12.2021 === smarttvnews.ru ===
https://smarttvnews.ru/wp-content/uploads/2018/11/BT-2016-logo_color7890.png
#EXTINF:-1,Ultra HD Cinema 4K UHD
#EXTGRP:Кино
http://zabava-htlive.cdn.ngenix.net/hls/CH_ULTRAHDCINEMA_HLS/bw20000000/variant.m3u8?version=2
#EXTINF:-1,ULTRA REX 4K UHD
#EXTGRP:Кино
https://zabava-htlive.cdn.ngenix.net/hls/CH_RUSSIANEXTREMEULTRA_HLS/bw20000000/variant.m3u8?version=2
"""
    static let linesExample: [M3UPlaylistLine] = [
        .extM3U,
        .extInf(-1, "=== Обновлён: 30.12.2021 === smarttvnews.ru ==="),
        .resource("https://smarttvnews.ru/wp-content/uploads/2018/11/BT-2016-logo_color7890.png"),
        .extInf(-1, "Ultra HD Cinema 4K UHD"),
        .extGrp("Кино"),
        .resource("http://zabava-htlive.cdn.ngenix.net/hls/CH_ULTRAHDCINEMA_HLS/bw20000000/variant.m3u8?version=2"),
        .extInf(-1, "ULTRA REX 4K UHD"),
        .extGrp("Кино"),
        .resource("https://zabava-htlive.cdn.ngenix.net/hls/CH_RUSSIANEXTREMEULTRA_HLS/bw20000000/variant.m3u8?version=2")
    ]
    
    
}
