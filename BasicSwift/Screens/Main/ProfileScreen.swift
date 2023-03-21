//
//  ProfileScreen.swift
//  BasicSwift
//
//  Created by remotestate on 16/03/23.
//

import Foundation
import SwiftUI

struct ProfileScreen:View{
    var body: some View{
        VStack(spacing:0){
            HomeAppBar(title: "Your Profile")
            ScrollView{
               
                Image("profileBG")
                    .resizable()
                    .frame(width: .infinity, height: 178)
                    .padding(.top,16)
                    .padding(.horizontal, 16)
                Image("user1")
                    .resizable()
                    .frame(width: 132, height: 132)
                    .overlay{
                        RoundedRectangle(cornerRadius: 130)
                            .stroke(AppColors.grayScaleWhite, lineWidth: 3)
                    }
                
                    .offset(y:-66)
                    .padding(.bottom,-66)
                
                Text("Mathew Robinson")
                    .font(.system(size: 22,weight: Font.Weight.bold))
                    .padding(.top,18)
                    .foregroundColor(AppColors.grayScaleBlack)
                
                Text("Mathew Robinson")
                    .font(.system(size: 16,weight: Font.Weight.light))
                    .foregroundColor(AppColors.grayScaleGray5)
                HStack{
                    Image("userGroup")
                        .resizable()
                        .frame(width: 24, height: 24)
                        .foregroundColor(AppColors.grayScaleGray5)
                        .padding(.leading,16)
                    Text("128 connections")
                        .foregroundColor(AppColors.grayScaleGray5)
                        .font(.system(size: 14))
                        .padding(.trailing,16)
                        .padding(.vertical,8)
                }
                .overlay {
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(AppColors.grayScaleGray5, lineWidth: 1)
                }
                
                Group{
                    
                
                    VStack(alignment: .leading,spacing: 0){
                        Text("Looking for")
                            .font(.system(size: 16,weight: Font.Weight.bold))
                            .foregroundColor(AppColors.grayScaleBlack)
                            .multilineTextAlignment(.leading)
                        
                            
                        
                        Text("Bring to the table win-win survival strategies to ensure proactive. At the end of the day, a new normal that has evolved into innovative construction for car enthusiests in the wild west ")
                            .font(.system(size: 16,weight: Font.Weight.light))
                            .foregroundColor(AppColors.grayScaleBlack)
                            .multilineTextAlignment(.leading)
                            .padding(.top,12)
                        
                        
                        Text("About me")
                            .font(.system(size: 16,weight: Font.Weight.bold))
                            .foregroundColor(AppColors.grayScaleBlack)
                            .multilineTextAlignment(.leading)
                            .padding(.top,24)
                        
                            
                        
                        Text("Leverage agile frameworks to provide a robust test for high level overviews. Iterative approaches to corporate strategy foster collaborative timing.")
                            .font(.system(size: 16,weight: Font.Weight.light))
                            .foregroundColor(AppColors.grayScaleBlack)
                            .multilineTextAlignment(.leading)
                            .padding(.top)
                        
                        
                        Text("Ideal contents")
                            .font(.system(size: 16,weight: Font.Weight.bold))
                            .foregroundColor(AppColors.grayScaleBlack)
                            .multilineTextAlignment(.leading)
                            .padding(.top,24)
                        let data = (0...5).map { Int in
                            "Item \(Int)"
                        }
                        
                        let columns = [
                            GridItem(.flexible()),
                            GridItem(.flexible()),
                            GridItem(.flexible())
                        ]
                        LazyVGrid(columns: columns) {
                            ForEach(data, id : \.self){ item in
                                HStack(spacing: 0){
                                    Image("industries")
                                    Text(item)
                                    
                                }
                                .padding(.horizontal,12)
                                .padding(.vertical,8)
                                .background(AppColors.primarySuperLightGreen)
                                .cornerRadius(20)
                                
                            }
                        }
                        .padding(.top,12)
                        
                        
                        
                    }
                    .frame(minWidth: 0, maxWidth: .infinity,alignment: .leading)
                    .padding(.horizontal,16)
                    .padding(.top,24)
             
                    
                
                }
                
                Spacer()
                
            }
        }
    }
}

struct ProfileScreenPreview : PreviewProvider {
    static var previews: some View{
        ProfileScreen()
    }
}
