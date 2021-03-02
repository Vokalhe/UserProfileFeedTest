//
//  ContentView.swift
//  UserProfileFeedTest
//
//  Created by Iris on 2/27/21.
//

import SwiftUI

enum UserListDisplay: Int {
    case followers
    case following
}

struct ContentView: View {
    let threeColumnGrid: [GridItem] = Array(repeating: .init(.flexible()), count: 3)

    var body: some View {
        NavigationView {
            GeometryReader { geo in
                ScrollView {
                    VStack(spacing: 10) {
                        UserProfileHeaderView()
                        
                        LazyVGrid(columns: threeColumnGrid, spacing: 2) {
                            
                            ForEach(0..<10) { index in
                                UserProfileFeedItem()
                                    .onTapGesture {

                                    }
                                    .frame(width: (geo.size.width / 3), height: 200)
                            }
                        }

                    }
                }
            }
            .navigationBarTitle("Username", displayMode: .inline)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct UserProfileFeedItem: View {
    var body: some View {
        GeometryReader { geom in
            
            ZStack(alignment: Alignment.center) {
                Color.green
                    .frame(height: geom.size.height)

                HStack {
                    VStack(alignment: .leading, spacing: 0) {
                        Image(systemName: "eye.slash.fill")
                        Spacer()
                        Text("distanceToPost")
                    }
                    
                    Spacer()
                }
                .padding(EdgeInsets(top: CGFloat(5), leading: CGFloat(5), bottom: CGFloat(0), trailing: CGFloat(5)))
            }
        }
//        .background(Color.black)
        .clipped()
    }
}

struct UserProfileHeaderView: View {
    let isCurrentUser = true
    @State private var isFollowing: Bool = false

    var body: some View {
        VStack(spacing: -16) {
            map()
            
            VStack(alignment: .leading, spacing: 18) {
                HStack(alignment: .top, spacing: 10) {
                    userAvatar()
                    
                    VStack {
                        Spacer().frame(height: 30)
                        
                        userProfileBioView()
                    }
                }

                locationView(isCurrentUser: isCurrentUser)
                
                if isCurrentUser { editProfileButton() }
                else { contactFollow() }
                
                counts()
            }
        }
        .padding([.trailing, .leading], 20)
    }
    
    private func map() -> some View {
        Color.gray
            .frame(height: 150)
            .clipShape(RoundedRectangle(cornerRadius: 20))
    }
    
    private func userAvatar() -> some View {
        Image(systemName: "circle")
            .resizable()
            .frame(width: 100, height: 100, alignment: .center)
            .clipShape(Circle())
            .overlay(
                Circle()
                    .fill(Color.blue)
                    .frame(width: 20, height: 20, alignment: .bottomTrailing)
                    .overlay(Circle().stroke(Color.red, lineWidth: 2))
                    .offset(x: 30, y: 30)
            )
    }
    
    private func userProfileBioView() -> some View {
        VStack(alignment: .leading, spacing: 5) {
            HStack(alignment: .center, spacing: 5.0) {
                
                Text("user.model.username")
                    .font(.headline)
                    .fontWeight(.semibold)
                
                Image(systemName: "checkmark.circle.fill")
                    .foregroundColor(Color.init(.sRGB, red: 0.918, green: 0.0, blue: 0.851, opacity: 100.0))
                    .shadow(radius: 1)
                    .font(.system(size: 14))
                    .contentShape(Rectangle())
            }
            Text("user.model.bio")
            Text("user.model.website")
        }
    }
    
    private func locationView(isCurrentUser: Bool) -> some View {
        Group {
            if isCurrentUser {
                Toggle(isOn: .constant(true), label: {
                    Image(systemName: "pin")
                        .renderingMode(.template)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 22, height: 22)
                    Text("makeLocationVisible")
                })
                .toggleStyle(SwitchToggleStyle(tint: .blue ))
                .onTapGesture {
                }
            } else {
                HStack(alignment: .center, spacing: 10) {
                    Image(systemName: "pin")
                        .renderingMode(.template)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 22, height: 22)
                    Text("North Pole, AK")
                }
            }
        }
    }
    
    private func editProfileButton() -> some View {
        Button(action: { editProfileView() }, label: {
           Text("Edit Profile")
            .fontWeight(.semibold)
            .foregroundColor(.secondary)
        })
        .buttonStyle(PlainButtonStyle())
        .padding(.vertical, 4)
        .frame(height: 32)
        .frame(maxWidth: .infinity)
        .background(RoundedRectangle(cornerRadius: 6).fill(Color(.systemGray5)))
    }
    
    private func editProfileView() -> some View {
        return EmptyView()
    }
    
    private func contactFollow() -> some View {
        HStack {
            Button(action: {}, label: {
                Text("Contact")
                    .fontWeight(.semibold)
                    .padding()
            })
            .buttonStyle(RoundedCornerStyle(backgroundColor: isFollowing ? Color.blue : nil))
            .allowsHitTesting(isFollowing)

            Button(action: {}, label: {
                Text("Follow")
                    .fontWeight(.semibold)
                    .padding()
            })
            .buttonStyle(RoundedCornerStyle())
        }
    }
    
    private func counts() -> some View {
        let likeCt = 13
        let postCt = 2
        let followerCt = 4
        let followingCt = 13
        
        return HStack(alignment: .top, spacing: 5) {
    
            countView(title: "Posts", count: postCt)
                        
            countView(title: "Followers", count: followerCt)
                .onTapGesture { userListView(display: .followers) }
    
            countView(title: "Following", count: followingCt)
                .onTapGesture { userListView(display: .following) }
            
            countView(title: "Likes", count: likeCt)
        }
    }
    
    private func countView(title: String, count: Int?) -> some View {
        VStack(spacing: 5) {
            Text("\(count ?? 0)")
                .font(.headline)
                .fontWeight(.semibold)
                .frame(maxWidth: .infinity)
            Text("\(title)")
                .foregroundColor(.secondary)
                .frame(maxWidth: .infinity)
        }
    }
    
    private func userListView(display: UserListDisplay) -> some View {
        return EmptyView().background(Color.red  )
    }
}

//struct UserProfileHeaderView_Previews: PreviewProvider {
//    static var previews: some View {
//        UserProfileHeaderView()
//    }
//}

struct RoundedCornerStyle: ButtonStyle {

    var backgroundColor: Color?

    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .padding(.vertical, 4)
            .frame(height: 32)
            .frame(maxWidth: .infinity)
            .background(RoundedRectangle(cornerRadius: 6).fill(backgroundColor ?? Color(.systemGray5)))
    }
}
