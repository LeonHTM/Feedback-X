//
//  CountryPickerView.swift
//  Feedback X
//
//  Created by Leon  on 26.12.2024.
//  Copyright © 2024 LeonHTM. All rights reserved.
//

import Foundation

public struct PublicSaves {
    public static let countriesAndTerritories: [String] = [
        "Afghanistan", "Åland Islands", "Albania", "Algeria", "American Samoa", "Andorra", "Angola", "Anguilla",
        "Antarctica", "Antigua And Barbuda", "Argentina", "Armenia", "Aruba", "Australia", "Austria", "Azerbaijan",
        "Bahamas", "Bahrain", "Bangladesh", "Barbados", "Belarus", "Belgium", "Belize", "Benin", "Bermuda",
        "Bhutan", "Bolivia", "Bosnia and Herzegovina", "Botswana", "Bouvet Island", "Brazil", "British Virgin Islands",
        "Brunei Darussalam", "Bulgaria", "Burkina Faso", "Burundi", "Cambodia", "Cameroon", "Canada", "Cape Verde",
        "Caribbean Netherlands", "Cayman Islands", "Central African Republic", "Chad", "Chagos Archipelago", "Chile",
        "China mainland", "Christmas Island", "Cocos (Keeling) Islands", "Colombia", "Comoros", "Cook Islands",
        "Costa Rica", "Côte d'Ivoire", "Croatia", "Curaçao", "Cyprus", "Czechia", "Democratic Republic of the Congo",
        "Denmark", "Djibouti", "Dominica", "Dominican Republic","DrakyLand", "Ecuador", "Egypt", "El Salvador", "Equatorial Guinea",
        "Eritrea", "Estonia", "Eswatini", "Ethiopia", "Falkland Islands", "Faroe Islands", "Fiji", "Finland", "France",
        "French Guiana", "French Polynesia", "French Southern Territories", "Gabon", "Gambia", "Georgia", "Germany",
        "Ghana", "Gibraltar", "Greece", "Greenland", "Grenada", "Guadeloupe", "Guam", "Guatemala", "Guernsey", "Guinea",
        "Guinea-Bissau", "Guyana", "Haiti", "Heard And Mc Donald Islands", "Honduras", "Hong Kong", "Hungary", "Iceland",
        "India", "Indonesia", "Iraq", "Ireland", "Isle of Man", "Israel", "Italy", "Jamaica", "Japan", "Jersey", "Jordan",
        "Kazakhstan", "Kenya", "Kiribati", "Kosovo", "Kuwait", "Kyrgyzstan", "Laos", "Latvia", "Lebanon", "Lesotho",
        "Liberia", "Libya", "Liechtenstein", "Lithuania", "Luxembourg", "Macao", "Madagascar", "Malawi", "Malaysia",
        "Maldives", "Mali", "Malta", "Marshall Islands", "Martinique", "Mauritania", "Mauritius", "Mayotte", "Mexico",
        "Micronesia", "Moldova", "Monaco", "Mongolia", "Montenegro", "Montserrat", "Morocco", "Mozambique", "Myanmar",
        "Namibia", "Nauru", "Nepal", "Netherlands", "New Caledonia", "New Zealand", "Nicaragua", "Niger", "Nigeria",
        "Niue", "Norfolk Island", "Northern Mariana Islands", "North Macedonia", "Norway", "Oman", "Pakistan", "Palau",
        "Palestinian Territories", "Panama", "Papua New Guinea", "Paraguay", "Peru", "Philippines", "Pitcairn", "Poland",
        "Portugal", "Puerto Rico", "Qatar", "Republic of the Congo", "Réunion", "Romania", "Russia", "Rwanda",
        "Saint Barthélemy", "Saint Helena", "Saint Kitts And Nevis", "Saint Lucia", "Saint Martin",
        "Saint Vincent and the Grenadines", "Samoa", "San Marino", "Sao Tome And Principe", "Saudi Arabia", "Senegal",
        "Serbia", "Seychelles", "Sierra Leone", "Singapore", "Sint Maarten", "Slovakia", "Slovenia", "Solomon Islands",
        "Somalia", "South Africa", "South Georgia and South Sandwich Islands", "South Korea", "South Sudan", "Spain",
        "Sri Lanka", "St. Pierre And Miquelon", "Sudan", "Suriname", "Svalbard And Jan Mayen Islands", "Sweden",
        "Switzerland", "Taiwan", "Tajikistan", "Tanzania", "Thailand", "Timor-Leste", "Togo", "Tokelau", "Tonga",
        "Trinidad and Tobago", "Tunisia", "Türkiye", "Turkmenistan", "Turks and Caicos Islands", "Tuvalu", "Uganda",
        "Ukraine", "United Arab Emirates", "United Kingdom", "United States", "United States Minor Outlying Islands",
        "Uruguay", "Uzbekistan", "Vanuatu", "Vatican", "Venezuela", "Vietnam", "Virgin Islands (U.S.)",
        "Wallis And Futuna Islands", "Western Sahara", "Yemen", "Zambia", "Zimbabwe"
    ]
    public static let feedbackAreasiOS: [String] = [
        "3rd Party Apps",
        "Accessibility",
        "AirDrop",
        "AirPlay",
        "AirPods",
        "App Privacy Report",
        "App Store",
        "App Switcher",
        "Apple Intelligence",
        "Apple Pay",
        "Audio",
        "Auto Unlock",
        "Backup",
        "Battery Charging",
        "Battery Life",
        "Bluetooth",
        "Books",
        "Calculator",
        "Calendar",
        "Camera",
        "Car Keys",
        "CarPlay",
        "Cellular Service (Calls & Data)",
        "Clock",
        "Contacts",
        "Continuity/Handoff",
        "Control Center",
        "Device Feels Warm",
        "Device Syncing",
        "Face ID",
        "FaceTime",
        "FaceTime - SharePlay",
        "Feedback Assistant",
        "Files app",
        "Find My",
        "Fitness/Fitness+",
        "Focus",
        "Freeform",
        "Game Controller",
        "Haptics/Vibration",
        "Health",
        "Home App & HomeKit / Matter Accessories",
        "Home Screen",
        "iCloud",
        "Image Playground",
        "iTunes Store",
        "Journal",
        "Keyboard",
        "Lock Screen",
        "Mail",
        "Maps",
        "Messages",
        "Music",
        "Music Classical",
        "News",
        "Notes",
        "Notification Center",
        "Notifications",
        "Passwords",
        "Phone app",
        "Photos",
        "Picture in Picture",
        "Podcasts",
        "Printing",
        "Reminders",
        "Rotation",
        "Safari",
        "Safety Check",
        "Screen Recording",
        "Screen Time",
        "Scribble",
        "Security",
        "Settings",
        "Share Sheet",
        "Shortcuts",
        "Sidecar",
        "Siri",
        "Sleep",
        "Software Update",
        "Split View/Drag and Drop",
        "Spotlight Search",
        "Stage Manager",
        "StandBy",
        "System Crashes",
        "System Slow/Unresponsive",
        "Touch ID",
        "Translate app",
        "Translation/Localization",
        "TV app/Apple TV+",
        "VPN",
        "Wallet",
        "Wallpaper",
        "Watch app",
        "Weather",
        "Wi-Fi",
        "Something else not on this list"
    ]
    public static let feedbackTypes: [String] =  [
        "Incorrect/Unexpected Behavior",
        "Application Crash",
        "Application Slow/Unresponsive",
        "Battery Life",
        "Suggestion"
    ]
        
}
