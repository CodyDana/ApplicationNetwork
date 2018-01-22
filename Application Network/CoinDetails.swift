//
//  CoinDetails.swift
//  Application Network
//
//  Created by Cody Dana on 1/20/18.
//  Copyright © 2018 Cody Dana. All rights reserved.
//

import Foundation

struct coinDetails {
    let id: String;
    let name: String;
    let symbol: String;
    let rank: Int;
    let price_usd: Int;
    let price_btc: Int;
    let twentyFourHr_volume_usd: Int;
    let market_cap_usd: Int;
    let available_supply: Int;
    let total_supply: Int;
    let max_supply: Int;
    let percent_change_1h: Int;
    let percent_change_24h: Int;
    let percent_change_7d: Int;
    let last_updated: Int;
}
