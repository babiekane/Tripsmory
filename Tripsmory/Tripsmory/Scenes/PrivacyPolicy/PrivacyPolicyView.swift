//
//  PrivacyPolicyView.swift
//  Tripsmory
//
//  Created by CatMeox on 23/6/2566 BE.
//

import SwiftUI

struct PrivacyPolicyView: View {
  
  @Environment(\.dismiss) var dismiss
  
  var body: some View {
    VStack(alignment: .center) {
      ZStack {
        Button {
          dismiss()
        } label: {
          HStack(alignment: .center, spacing: 0) {
            Image(systemName: "chevron.backward")
              .font(.title2)
              .fontWeight(.semibold)
              .foregroundColor(Color("greenDark"))
            
            Spacer()
          }
        }
        
        HStack(alignment: .center, spacing: 0) {
          Spacer()
          
          Text("Privacy policy")
            .font(.custom("Jost", size: 24))
            .bold()
            .foregroundColor(Color("greenDark"))
          
          Spacer()
        }
      }
      .padding(.vertical, 12)
      
      ScrollView(showsIndicators: false) {
        VStack(alignment: .leading, spacing: 12) {
          Text("Phattaraporn H. built the Tripsmory app as a Free app. This SERVICE is provided by Phattaraporn H. at no cost and is intended for use as is.")
          
          Text("This page is used to inform visitors regarding my policies with the collection, use, and disclosure of Personal Information if anyone decided to use my Service.")
          
          Text("If you choose to use my Service, then you agree to the collection and use of information in relation to this policy. The Personal Information that I collect is used for providing and improving the Service. I will not use or share your information with anyone except as described in this Privacy Policy.")
          
          Text("The terms used in this Privacy Policy have the same meanings as in our Terms and Conditions, which are accessible at Tripsmory unless otherwise defined in this Privacy Policy.")
        }
        .padding(.bottom, 24)
        
        VStack(alignment: .leading, spacing: 12) {
          Text("Information Collection and Use")
            .bold()
          
          Text("For a better experience, while using our Service, I may require you to provide us with certain personally identifiable information. The information that I request will be retained on your device and is not collected by me in any way.")
          
          Text("The app does use third-party services that may collect information used to identify you.")
          
          Text("Link to the privacy policy of third-party service providers used by the app")
          
          Text("[∙ Facebook](https://www.facebook.com/about/privacy/update/printable)")
            .padding(.leading, 12)
        }
        .padding(.bottom, 24)
        
        VStack(alignment: .leading, spacing: 12) {
          Text("Log Data")
            .bold()
          
          Text("I want to inform you that whenever you use my Service, in a case of an error in the app I collect data and information (through third-party products) on your phone called Log Data. This Log Data may include information such as your device Internet Protocol (“IP”) address, device name, operating system version, the configuration of the app when utilizing my Service, the time and date of your use of the Service, and other statistics.")
        }
        .padding(.bottom, 24)
        
        VStack(alignment: .leading, spacing: 12) {
          Text("Cookies")
            .bold()
          
          Text("Cookies are files with a small amount of data that are commonly used as anonymous unique identifiers. These are sent to your browser from the websites that you visit and are stored on your device's internal memory.")
          
          Text("This Service does not use these “cookies” explicitly. However, the app may use third-party code and libraries that use “cookies” to collect information and improve their services. You have the option to either accept or refuse these cookies and know when a cookie is being sent to your device. If you choose to refuse our cookies, you may not be able to use some portions of this Service.")
        }
        .padding(.bottom, 24)
        
        VStack(alignment: .leading, spacing: 12) {
          Text("Service Providers")
            .bold()
          
          Text("I may employ third-party companies and individuals due to the following reasons:")
          
          Text("""
                 ∙ To facilitate our Service;
                 ∙ To provide the Service on our behalf;
                 ∙ To perform Service-related services; or
                 ∙ To assist us in analyzing how our Service is used.
                 """)
          .frame(alignment: .leading)
          .padding(.leading, 12)
          
          Text("I want to inform users of this Service that these third parties have access to their Personal Information. The reason is to perform the tasks assigned to them on our behalf. However, they are obligated not to disclose or use the information for any other purpose.")
        }
        .padding(.bottom, 24)
        
        VStack(alignment: .leading, spacing: 12) {
          Text("Security")
            .bold()
          
          Text("I value your trust in providing us your Personal Information, thus we are striving to use commercially acceptable means of protecting it. But remember that no method of transmission over the internet, or method of electronic storage is 100% secure and reliable, and I cannot guarantee its absolute security.")
        }
        .padding(.bottom, 24)
        
        VStack(alignment: .leading, spacing: 12) {
          Text("Links to Other Sites")
            .bold()
          
          Text("This Service may contain links to other sites. If you click on a third-party link, you will be directed to that site. Note that these external sites are not operated by me. Therefore, I strongly advise you to review the Privacy Policy of these websites. I have no control over and assume no responsibility for the content, privacy policies, or practices of any third-party sites or services.")
        }
        .padding(.bottom, 24)
        
        VStack(alignment: .leading, spacing: 12) {
          Text("Children’s Privacy")
            .bold()
          
          Text("These Services do not address anyone under the age of 13. I do not knowingly collect personally identifiable information from children under 13 years of age. In the case I discover that a child under 13 has provided me with personal information, I immediately delete this from our servers. If you are a parent or guardian and you are aware that your child has provided us with personal information, please contact me so that I will be able to do the necessary actions.")
        }
        .padding(.bottom, 24)
        
        VStack(alignment: .leading, spacing: 12) {
          Text("Changes to This Privacy Policy")
            .bold()
          
          Text("I may update our Privacy Policy from time to time. Thus, you are advised to review this page periodically for any changes. I will notify you of any changes by posting the new Privacy Policy on this page.")
          
          Text("This policy is effective as of 15-06-2023")
        }
        .padding(.bottom, 24)
        
        VStack(alignment: .leading, spacing: 12) {
          Text("Contact Us")
            .bold()
          
          Text("If you have any questions or suggestions about my Privacy Policy, do not hesitate to contact me at tripsmoryapp@gmail.com.")
          
          Text("This privacy policy page was created at ")
          +
          Text("[privacypolicytemplate.net](https://www.privacypolicytemplate.net/)")
          +
          Text(" and modified/generated by ")
          +
          Text("[App Privacy Policy Generator](https://app-privacy-policy-generator.nisrulz.com/)")
        }
        .padding(.bottom, 24)
      }
    }
    .font(.custom("Jost", size: 16))
    .foregroundColor(Color("appBlack"))
    .padding(.horizontal, 36)
    .preferredColorScheme(.light)
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .background(Color("appWhite"))
  }
}
