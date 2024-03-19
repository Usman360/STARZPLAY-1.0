//
//  PagerView.swift
//  STARZPLAY
//
//  Created by Usman on 18/03/2024.
//

import SwiftUI

struct PagerView: View {
    
    @Binding var selection : Int
    @Binding  var menuList : [SeasonsTapModel]
    
    var body: some View {
        
        GeometryReader { geometry in
            ScrollView(.horizontal, showsIndicators: false) {
                
                if #available(iOS 14.0, *) {
                    ScrollViewReader { value in
                        
                        VStack(alignment: .leading, spacing: 0) {
                            
                            HStack {
                                ForEach(self.menuList) { menuItem in
                                    VStack (alignment: .leading){
                                        
                                        
                                        if self.menuList.count == 1{
                                            HStack{
                                                Text(menuItem.name)
                                                    .customFont(weight: .bold, size: 14)
                                                    .foregroundColor(self.selection == menuItem.id ? .white : .gray)
                                                    .frame(width: (geometry.size.width / 2), height: 20)
                                                Spacer()
                                                if menuItem.id != menuList.last?.id {
                                                    Rectangle().fill(Color.white).frame(width: 1, height: 15)
                                                }
                                            }
                                            
                                        }
                                        else if self.menuList.count == 2{
                                            HStack{
                                                Text(menuItem.name)
                                                    .customFont(weight: .bold, size: 14)
                                                    .foregroundColor(self.selection == menuItem.id ? .white : .gray)
                                                    .frame(width: (geometry.size.width / 2), height: 20)
                                                Spacer()
                                                if menuItem.id != menuList.last?.id {
                                                    Rectangle().fill(Color.white).frame(width: 1, height: 15)
                                                }
                                            }
                                            
                                        }
                                        else if self.menuList.count >= 3{
                                            
                                            HStack{
                                                Text(menuItem.name)
                                                    .customFont(weight: .bold, size: 14)
                                                    .foregroundColor(self.selection == menuItem.id ? .white : .gray)
                                                    .frame(width: (geometry.size.width / 3), height: 20)
                                                Spacer()
                                                if menuItem.id != menuList.last?.id {
                                                    Rectangle().fill(Color.gray).frame(width: 1, height: 15)
                                                }
                                                
                                            }
                                        }
                                        Spacer()
                                        if(self.selection == menuItem.id) {
                                            
                                            Rectangle().fill(Color.white)
                                                .frame(height: CGFloat(2))
                                                .offset(y: -10)
                                            
                                        }
                                    }
                                    .frame(height: 40)
                                    .onTapGesture {
                                        
                                        DispatchQueue.main.async {
                                            self.selection = menuItem.id
                                            withAnimation {
                                                if menuItem.id != menuList.last?.id {
                                                    
                                                    value.scrollTo(menuItem.id, anchor: .center)
                                                }
                                                else if menuItem.id == menuList.last?.id{
                                                    value.scrollTo(menuItem.id, anchor: .trailing)
                                                }
                                            }
                                        }
                                        
                                    }
                                }
                            }
                            .frame(height: 45)
                            
                            
                        }
                    }
                } else {
                    // Fallback on earlier versions
                    VStack(spacing: 0) {
                        HStack {
                            ForEach(self.menuList) { menuItem in
                                VStack {
                                    Spacer()
                                    Text(menuItem.name)
                                        .customFont(weight: .bold, size: 14)
                                        .multilineTextAlignment(.center)
                                        .frame(width: geometry.size.width / 3, height: 45)
                                    Spacer()
                                    
                                    if(self.selection == menuItem.id) {
                                        Rectangle().fill(Color.white)
                                            .frame(height: CGFloat(3))
                                            .offset(y: -5)
                                        
                                    }
                                }
                                .frame(height: 55)
                                .onTapGesture {
                                    self.selection = menuItem.id
                                }
                            }
                        }
                        .frame(height: 54)
                        Divider()
                            .frame(width:UIScreen.main.bounds.width + 5)
                            .background(Color.white)
                            .foregroundColor(Color.red)
                    }
                }
                
            }
        }
        .frame(height: 54)
    }
}

