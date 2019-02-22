import UIKit
import  SwiftHEXColors

extension UIColor{
    
    // MARK: Global
    
    // new update
    static var yellowMainColor: UIColor{
        return UIColor(hexString: "DEBA3A")!
    }
    static var blueMainColor: UIColor{
        return UIColor(hexString: "3C4B66")!
    }
    static var greenMainColor: UIColor{
        return UIColor(hexString: "69a028")!
    }
    
    static var redMainColor: UIColor{
        return UIColor(hexString: "D11E29")!
    }
    
    static var orangeMainColor: UIColor{
        return UIColor(hexString: "e1a32a")!
    }
    
    static var blackMainTitleColor: UIColor{
        return UIColor(hexString: "323232")!
    }
    
    static var blackSubtitleTitleColor: UIColor{
        return UIColor(hexString: "464646")!
    }
    
    static var grayLightBackgroundColor: UIColor{
        return UIColor(hexString: "F3F4F8")!
    }
    
    static var tableViewBackgroundColor: UIColor{
        return grayLightBackgroundColor
    }
    
    static var grayRadialGradientColor: UIColor{
        return UIColor(hexString: "f1f2f2")!
    }
    
    static var grayButtonColor: UIColor{
        return UIColor(hexString: "434344")!
    }
    static var grayMainColor: UIColor{
        return UIColor(hexString: "B1B7C2")!
    }
    
    static var blueTextColor: UIColor{
        return UIColor(hexString: "487489")!
    }
    static var grayStatusOrderColor: UIColor{
        return UIColor(hexString: "bdbebf")!
    }
    static var blueStatusOrderColor: UIColor{
        return UIColor(hexString: "487489")!
    }
    static var orangeStatusOrderColor: UIColor{
        return UIColor(hexString: "e1a32a")!
    }
    static var redStatusOrderColor: UIColor{
        return UIColor(hexString: "d22730")!
    }
    
    
    struct MethodReceive {
        static var activeBackgroundColor: UIColor{
            return UIColor(hexString: "3C4B64")!
        }
        static var normalBackgroundColor: UIColor{
            return UIColor(hexString: "E5EAF0")!
        }
        
        static var titleColor: UIColor{
            return UIColor(hexString: "5F6B82")!
        }
        static var detailColor: UIColor{
            return UIColor(hexString: "3C4B64")!
        }
    }

    
    // -------------
    
    struct NavigationBar {
        static var navigationBarBackgroundColor: UIColor{
            return yellowMainColor
        }
        
        static var navigationBarTitleColor: UIColor{
            return blackMainTitleColor
        }
        
    }

    struct ProductList {
        static var bookmarkColor: UIColor{
            return greenMainColor
        }
        
        static var modalViewColor: UIColor{
            return UIColor(hexString: "2d2d2d")!
        }
    }
    
    struct ShopList{
        static var tabNormalBackgroundColor: UIColor{
            return UIColor.init(hexString: "d3d6dc")!
        }
        
        static var tabHighLightBackgroundColor: UIColor{
            return blackMainTitleColor
        }
        
        static var grayTitleColor: UIColor{
            return UIColor(hexString: "373737")!
        }
        
        static var graySubTitleColor: UIColor{
            return .graySubTitleColor
        }
        
        static var grayLocationTitleColor: UIColor{
            return UIColor(hexString: "919191")!
        }
        
        static var grayTermTitleColor: UIColor{
            return .grayMainTextColor
        }
        
        static var grayTableSeperatorColor: UIColor{
            return UIColor(hexString: "f0f0f0")!
        }
        
        static var buttonOrderColor: UIColor{
            return UIColor.greenMainColor
        }
        
        static var buttonDetailColor: UIColor{
            return UIColor.blackMainTitleColor
        }
        
        static var labelPriceColor: UIColor{
            return UIColor.greenMainColor
        }
        
        static var productDetailImageColor: UIColor{
            return UIColor.grayLightBackgroundColor
        }
        
        static var buttonSearchBackgroundColor: UIColor{
            return UIColor.blackMainTitleColor
        }
    }
    
    // MARK: Agency
    struct Agency {
        
//            Edited by Tuan Pham 14 Aug, 2017
        
        static var backgroundColor: UIColor {
            return UIColor.init(hexString: "#efefef")!
        }
        
        static var highlightSortOptionColor: UIColor {
            return UIColor.init(hexString: "#3f3f3f")!
        }
        
        static var nonHighlightSortOptionColor: UIColor {
            return UIColor.init(hexString: "#aaaaaa")!
        }
        
        static var lblPriceColor: UIColor {
            return UIColor.init(hexString: "#45ab00")!
        }
        
        static var lblOverrallRatingColor: UIColor {
            return UIColor.init(hexString: "#23a505")!
        }
        
        static var btnRateColor: UIColor {
            return UIColor.init(hexString: "#23a505")!
        }
        
        static var reviewBackGroundColor: UIColor {
            return UIColor.init(hexString: "#aaaaaa")!
        }
        
        static var btnRateTitleColor: UIColor {
            return UIColor.white
        }
        
        static var lblNoOfRatingColor: UIColor {
            return UIColor.init(hexString: "#aaaaaa")!
        }
        
//        ==============
//        static var tabNormalBackgroundColor: UIColor{
//            return yellowNonSelectedTab
//        }
//
//        static var tabHighLightBackgroundColor: UIColor{
//            return yellowSelectedTab
//        }
        
        static var textNormalColor: UIColor{
            return UIColor.init(hexString: "#464646")!
        }


        static var textHighLightColor: UIColor{
            return .white
        }
    }
    
    struct BookingMap {
        static var buttonSearchBackgroundColor: UIColor{
            return UIColor.blackMainTitleColor
        }
    }
    
    struct OrderNow{
        static var tabNormalBackgroundColor: UIColor{
            return UIColor.init(hexString: "d3d6dc")!
        }
        
        static var tabHighLightBackgroundColor: UIColor{
            return blackMainTitleColor
        }
        
        static var textNormalColor: UIColor{
            return blackMainTitleColor
        }
        
        static var textHighLightColor: UIColor{
            return .white
        }
    }
    
    struct RegisterService {
        static var compareItemBackgroundColor: UIColor{
            return UIColor(hexString: "d3d6dc")!
        }
        
        static var sectionTitleColor: UIColor{
            return UIColor(hexString: "3e3e40")!
        }
        
        static var titleColor: UIColor{
            return .blackSubtitleTitleColor
        }
        
        static var headerDetailColor: UIColor{
            return UIColor.greenMainColor
        }
        
        static var totalBackgroundColor: UIColor{
            return UIColor.yellowMainColor
        }
        
        static var grayRecipeSeparatorColor: UIColor{
            return UIColor(hexString: "adabaa")!
        }
        
        static var quantityBackgroundColor: UIColor{
            return UIColor.white
        }
        
        static var receiptBackgroundColor: UIColor{
            return UIColor.grayRadialGradientColor
        }
        
        static var blueGasActiveColor: UIColor{
            return UIColor(hexString: "25bded")!
        }
        
    }
    
    struct Buttons {
        static var grayBackgroundColor: UIColor{
            return UIColor.grayButtonColor
        }
        
        static var greenBackgroundColor: UIColor{
            return UIColor.greenMainColor
        }
    }
    
    struct BookingOrder {
        static var headerTitleColor: UIColor{
            return UIColor.blackMainTitleColor
        }

        static var segmentNormalBackgroundColor: UIColor{
            return UIColor(hexString: "e8e8e8")!
        }
        
        static var segmentHighLightBackgroundColor: UIColor{
            return UIColor.yellowMainColor
        }
        
        static var segmentTitleColor: UIColor{
            return UIColor.blackMainTitleColor
        }
        
        static var separatorColor: UIColor{
            return UIColor.grayLightBackgroundColor
        }
        
        static var titleColor: UIColor{
            return UIColor.blackSubtitleTitleColor
        }
    }
    
    // MARK: Login view
    struct LoginView {
        static var grayTextColor: UIColor{
            return UIColor(hexString: "828282")!
        }
        
        static var graySeperatorColor: UIColor{
            return UIColor(hexString: "969696")!
        }
        
        static var grayButtonColor: UIColor{
            return UIColor(hexString: "B7B7B7")!
        }
    }
    
    
    struct LeftMenu {
        static var grayItemTextColor: UIColor{
            return UIColor(hexString: "595968")!
        }
        
        static var orangeLocationTextColor: UIColor{
            return UIColor(hexString: "E89B02")!
        }
        
        static var redBadgeColor: UIColor{
            return UIColor(hexString: "CC3633")!
        }
        
        static var grayHeaderCellColor: UIColor{
            return UIColor(hexString: "F5F6F7")!
        }
        
        static var grayLogoutCellColor: UIColor{
            return UIColor(hexString: "AAAAAA")!
        }
        
        static var graySeparatorColor: UIColor{
            return graySubTitleColor
        }
        
        static var highlightCellColor: UIColor{
            return UIColor(hexString: "f5f5f5")!
        }
        
    }
    
    struct Profile {
        static var grayBackgroundColor: UIColor{
            return UIColor(hexString: "F1F1F2")!
        }
        
        static var pointColor: UIColor{
            return UIColor.redMainColor
        }
        
        static var pointTitleColor: UIColor{
            return UIColor(hexString: "5e5e5e")!
        }
        
        static var promotionPointBackgroundColor: UIColor{
            return UIColor.redMainColor
        }
        
        static var userIdColor: UIColor{
            return UIColor.orangeMainColor
        }
        
        static var grayTextFieldBorderColor: UIColor{
            return UIColor(hexString: "C1C1C1")!
        }
        
        static var graySeparatorLineColor: UIColor{
            return UIColor(hexString: "5d5d5d")!
        }
        
        static var grayMemberTitleColor: UIColor{
            return UIColor(hexString: "373737")!
        }
    }

    struct Conversation {
        static var buttonColor: UIColor{
            return UIColor.greenMainColor
        }
        
        static var dateColor: UIColor{
            return UIColor(hexString: "464646")!
        }
    }
    
     static var grayMainTitleColor: UIColor{
        return UIColor(hexString: "4B4B4B")!
    }
    
    static var graySubTitleColor: UIColor{
        return UIColor(hexString: "5E5E5E")!
    }
    
    static var grayMainTextColor: UIColor{
        return UIColor(hexString: "606060")!
    }
    
    static var grayLightTextColor: UIColor{
        return UIColor(hexString: "969696")!
    }
    
    static var orangeBackgroundColor: UIColor{
        return UIColor(hexString: "E89B02")!
    }
    
    
    static var grayLightBorderColor: UIColor{
        return UIColor(hexString: "5e5f5e")!
    }
    
    static var underlineColor: UIColor{
        return UIColor(hexString: "231f20")!
    }

    

    
    static var titleColor: UIColor{
        return UIColor(hexString: "2d2d2d")!
    }
    
    static var redTextColor: UIColor{
        return UIColor(hexString: "ad0700")!
    }
    
    static var placeHolderTextColor: UIColor{
        return UIColor(hexString: "8e8e8e")!
    }
    
    
    
    
    
    struct ShoppingItem {
        static var redOverlayColor: UIColor{
            return UIColor(hexString: "2D0C0C")!
        }
        
        static var redSeparatorColor: UIColor{
            return UIColor(hexString: "D40D12")!
        }
        
        static var grayTitleColor: UIColor{
            return UIColor(hexString: "373737")!
        }
        
        static var graySubTitleColor: UIColor{
            return .graySubTitleColor
        }
        
        static var grayLocationTitleColor: UIColor{
            return UIColor(hexString: "919191")!
        }
        
        static var grayTermTitleColor: UIColor{
            return .grayMainTextColor
        }
        
        static var grayTableSeperatorColor: UIColor{
            return UIColor(hexString: "f0f0f0")!
        }
        
    }
    
    struct Partner {
        static var grayHeaderTitleColor: UIColor{
            return UIColor(hexString: "474747")!
        }
        
        static var grayHeaderBackgroundColor: UIColor{
            return UIColor(hexString: "eaeaea")!
        }
        
    }
    
    
    
    struct BookInfo {
        static var graySeparatorColor: UIColor{
            return UIColor(hexString: "5d5d5d")!
        }
        
        static var grayWeekendDateColor: UIColor{
            return UIColor(hexString: "8c8b8b")!
        }
        
    }
    
    struct BookingPayment {
        static var blueSectionBackgroundColor: UIColor{
            return UIColor(hexString: "f2f4f4")!
        }

    }
    
    
    struct Notification {
        static var blueTimeTextColor: UIColor{
            return UIColor(hexString: "8ca7ae")!
        }
        
        static var grayBackgroundColor: UIColor{
            return UIColor(hexString: "dde1ec")!
        }
        
        static var grayTextColor: UIColor{
            return UIColor(hexString: "afafaf")!
        }
        
    }
    
    struct Monitor {
        static var blueResultColor: UIColor{
            return UIColor(hexString: "f2f5fa")!
        }
        
        static var darlBlueHeaderColor: UIColor{
            return UIColor(hexString: "3e4856")!
        }
    }
}
