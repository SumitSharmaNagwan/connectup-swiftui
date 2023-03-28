//
//  ButtonStyle.swift
//  BasicSwift
//
//  Created by remotestate on 24/03/23.
//

import Foundation
import SwiftUI

enum ButtonColorSolid : String{
    case Green, Red, Black, White
}

struct AllButton : View {
    @State
    var isDiable  = false
    var body: some View {
        
        Button(action: {
            
        }){
          
            Text("Label")
        }
       
        .buttonStyle(SecondaryButtonStyle(isDisable: isDiable))
       
    }
  
}




struct SecondaryButtonStyle : ButtonStyle {
    
    var isDisable = true
    
    func makeBody (configuration : Configuration) -> some View{
        configuration.label
            .multilineTextAlignment(.center)
            .frame(minWidth: 0, maxWidth: .infinity, maxHeight: 48)
         .overlay{
                RoundedRectangle(cornerRadius: 24)
                    .stroke(configuration.isPressed ? getPressedColor() :  isDisable ? getDisableColor() : getDefultColor(),lineWidth: 1)
            }
            .cornerRadius(24)
            .foregroundColor(getTextColor(isPresed: configuration.isPressed))
            .font(.system(size: 16,weight: Font.Weight.bold))
          
            .scaleEffect(configuration.isPressed ? 1.1 : 1)
              .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
     
             
           
    }
    
    func getTextColor(isPresed: Bool) -> Color {
        
        if isDisable {
            return AppColors.grayScaleGray2
        }else {
            if isPresed {
                return AppColors.grayScaleBlack
            }else {
                return AppColors.grayScaleSoftBlack
            }
          
        }
    }
    
    func getDefultColor () -> Color {
    
        return AppColors.grayScaleBlack
      
    }
    
    func getDisableColor () -> Color {
        return AppColors.grayScaleGray2
    }
    
    func getPressedColor () -> Color {
        return AppColors.redButtenPressed
    }
}



struct PrimaryButtonStyleSolid : ButtonStyle {
    
    var isDisable = false
    var buttonColorSolid : ButtonColorSolid
    func makeBody (configuration : Configuration) -> some View{
        configuration.label
            .multilineTextAlignment(.center)
            .frame(minWidth: 0, maxWidth: .infinity, maxHeight: 48)
            .background(configuration.isPressed ? getPressedColor() :  isDisable ? getDisableColor() : getDefultColor() )
            .cornerRadius(24)
            .foregroundColor(getTextColor())
            .font(.system(size: 16,weight: Font.Weight.bold))
           
    }
    
    func getTextColor() -> Color {
        switch buttonColorSolid {
        case .Green, .White :
            if isDisable {
                return AppColors.grayScaleGray4
            }else {
                return AppColors.grayScaleBlack
            }
         
         case .Black:
            if isDisable {
                return AppColors.grayScaleGray4
            }else {
                return AppColors.grayScaleWhite
            }
           
        case .Red:
            return AppColors.grayScaleWhite
        }

    }
    
    func getDefultColor () -> Color {
        switch buttonColorSolid {
        case .Green:
           return AppColors.primaryMainGreen
        case .Red:
           return AppColors.alertsError
        case .Black:
            return AppColors.grayScaleBlack
        case .White:
            return AppColors.grayScaleWhite
        }
    }
    
    func getDisableColor () -> Color {
        switch buttonColorSolid {
        case .Green:
           return AppColors.grayScaleGray2
        case .Red:
           return AppColors.redButtonDisable
        case .Black:
            return AppColors.grayScaleGray2
        case .White:
            return AppColors.grayScaleGray1
        }
    }
    
    func getPressedColor () -> Color {
        switch buttonColorSolid {
        case .Green:
           return AppColors.primarySoftGreen
        case .Red:
           return AppColors.redButtenPressed
        case .Black:
            return AppColors.grayScaleSoftBlack
        case .White:
            return AppColors.grayScaleGray1
        }
    }
}




struct AllButtonPreView : PreviewProvider {
    static var previews: some View{
        AllButton()
        
    }
}
