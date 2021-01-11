
//
//  EndPoints.swift
//
//  Created by JMD on 02/05/19.
//  Copyright © 2019 JMD. All rights reserved.
//

import UIKit
// For Live: https://beta.biryanioncloud.com/
// For dev => "http://dev-ekodus.com/boc/api/"
private let BASE_URL = "http://dev-ekodus.com/boc/api/"
public let MENUHEAD_BASE_URL = "https://beta.biryanioncloud.com/storage/menuhead/"
public let MENUITEM_IMAGEBASE_URL = "https://beta.biryanioncloud.com/storage/menuitem/"

// APIs
struct APIs {
    static let kLOGIN                       = BASE_URL + "authUserAccount"
    static let kSIGNUP                      = BASE_URL + "createAccount"
    static let kMY_PROFILE                  = BASE_URL + "getMyAccount"
    static let kMENU_HEAD                   = BASE_URL + "getUserMenuHeads"
    static let kMENU_ITEMS                  = BASE_URL + "getUserMenuItems"
    static let kCHNAGE_PASSWORD             = BASE_URL + "changeUserPassword"
    static let kUPDATE_PROFILE              = BASE_URL + "updateUserProfile"
    static let kGET_SAVED_ADDRESS           = BASE_URL + "getSavedAddreses"
    static let kSAVE_NEW_ADDRESS            = BASE_URL + "createNewAddress"
    static let kGET_MYORDER_LIST            = BASE_URL + "getMyOrdersList"
    static let kCREATE_CATRING_ORDER        = BASE_URL + "createCateringOrder"
    static let kAPPLY_COUPON                = BASE_URL + "getCouponValidation"
    static let kAVAILABLE_RESTAURANT        = BASE_URL + "getAvailableRestaurant"
    static let kGET_MENU_ITEM_BY_ID         = BASE_URL + "getMenuItemByID"
    static let kSAVE_CART_ORDER             = BASE_URL + "storeCartOrderRequest"
    static let kTEX_MASTER                  = BASE_URL + "getTaxMaster"
    static let kFEATURED_LIST               = BASE_URL + "fres"
    static let kFEATURED_RESTRO_DETAILS     = BASE_URL + "fresDetailIos"
    static let kSUGGEST_CUISINE             = BASE_URL + "suggestCuisine"
    static let kSEARCH_CUISINE_ID           = BASE_URL + "fresByCuisine"
    static let kADD_TO_CART                 = BASE_URL + "addToCart"
    static let kGET_CART                    = BASE_URL + "getCart"
    static let kUPDTAE_QTY                  = BASE_URL + "updateQuantity"
    static let kSCHEDULE_DT                 = BASE_URL + "getScheduleDates"
    static let kAPPLY_NEW_COUPON            = BASE_URL + "applyCoupon"
    static let kREMOVE_COUPON               = BASE_URL + "removecoupon"
    static let kAPPLY_TIP                   = BASE_URL + "applyTip"
    static let kREMOVE_TIP                  = BASE_URL + "removeTip"
    static let kDELETE_ITEM_FROM_CART       = BASE_URL + "deleteItemFromCart"
    static let kPLACE_ORDER                 = BASE_URL + "placeOrder"
}

