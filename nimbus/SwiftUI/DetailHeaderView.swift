//
//  DetailHeaderView.swift
//  nimbus-SwiftUI
//
//  Created by Perikles Maravelakis on 28/4/22.
//  Copyright © 2022 Cloudfields. All rights reserved.
//

import SwiftUI

struct DetailHeaderView_Previews: PreviewProvider {
	static var previews: some View {
		DetailHeaderView()
			.preferredColorScheme(.dark)
	}
}

struct DetailHeaderView: View {
	var cloud: Cloud = Cloud()
	
	var body: some View {
		VStack(alignment: .leading) {
			Text(cloud.initials)
				.font(.system(size: 45))
				.fontWeight(.light)
				.multilineTextAlignment(.center)
				.frame(width: 90.0, height: 90.0)
				.background(.indigo)
				.cornerRadius(45.0)
			
			VStack(alignment: .leading, spacing: 4.0) {
				Text("\(cloud.type!.name) altitude")
					.font(.system(size: 14))
					.fontWeight(.medium)
					.foregroundColor(.secondary)
				Text(cloud.name)
					.font(.system(size: 28))
					.fontWeight(.semibold)
			}
		}
		.padding(.top, -20.0)
	}
}



