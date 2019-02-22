//
//  OrderObject.swift
//  SEM
//
//  Created by Ipman on 1/16/19.
//  Copyright © 2019 Ipman. All rights reserved.
//

import UIKit
import ObjectMapper
class OrderObject: Mappable {
    var listProduct = [DeviceObject]()
    var id: Int? = nil
    var nameCustomer = ""
    var phoneCustomer =  ""
    var addressReceive = ""
    var emailCustomer = ""
    var tax: Double = 0
    var discount = ""
    var priceDiscount: Double = 0
    var total: Double = 0
    var subTotal: Double = 0
    var idPayment: Int? = nil
    var namePayment = ""
    var descriptionPayment = ""
    var idShipment: Int? = nil
    var nameShipment = ""
    var priceShipment: Double = 0
    var time: String? = nil
    var totalQuantity: Int = 0
    var status: Int? = nil
    var createdAt = ""
    var updatedAt = ""
    required convenience init?(map: Map){
        self.init()
    }
    func mapping(map: Map) {
        listProduct     <- map["lstProduct"]
        id              <- (map["id"], IntegerTransform())
        nameCustomer    <- map["name"]
        phoneCustomer   <- map["phone"]
        emailCustomer   <- map["email"]
        addressReceive  <- map["address"]
        tax             <- (map["tax"], DoubleTransform())
        discount                <- map["discount"]
        priceDiscount           <- (map["pricediscount"], DoubleTransform())
        total                   <- (map["total"], DoubleTransform())
        subTotal                <- (map["subtotal"], DoubleTransform())
        idPayment               <- (map["idPayment"], IntegerTransform())
        namePayment             <- map["namepayment"]
        descriptionPayment      <- map["descriptionpayment"]
        idShipment              <- (map["idShipment"], IntegerTransform())
        nameShipment            <- map["nameshipment"]
        priceShipment           <- (map["priceshipment"], DoubleTransform())
        time                    <- map["etmdDelTime"]
        totalQuantity           <- (map["quality"], IntegerTransform())
        status                  <- (map["status"], IntegerTransform())
        createdAt               <- map["createdAt"]
        updatedAt               <- map["updatedAt"]
    }
}
class ListOrderObject: Mappable {
    var list = [OrderObject]()
    required convenience init?(map: Map){
        self.init()
    }
    func mapping(map: Map) {
        list <- map["invoice"]
    }
}

class OrderDetailObject: Mappable {
    var info = OrderObject()
    var listProduct = [DeviceObject]()
    required convenience init?(map: Map){
        self.init()
    }
    func mapping(map: Map) {
        info              <- map["invoice"]
        listProduct       <- map["invoiceDetail"]
    }
}
