# Welcome to My Portfolio!

Hi! My name is David Orakpo. I am a Software Engineer specialized in Flutter/Xamarin. This project represents my interactive portfolio of the apps and designs I have worked on or reproduced. The app is a fairly simple one, consisting of 5 screens:
- Landing Page
- About Me
- Experience
- Portfolio
- Settings

The app supports features such as Dark Mode (auto and manual switching), responsiveness to phone Orientation as well. The minimum sdk level for this app is Android 12 (API 31) as well.

# Description of Code Base
The Code base applies the MVVM design architecture. However, I made use of enums as my models were not going to change in the life cycle of the app. For example, I stored the details of my Contact Information and Social Information in enum classes. These classes have corresponding fields such as Address, education and so on. From here, I make a list of all the values in both enums and attach them to a List View to display the value concisely

# Design
The design of the app was inspired by a mix of other projects I have worked on as well as Material Design. As these were personal/job projects, the designs were either original content, or belonging to the organization I work for.

# Libraries Used
I made use of a few libraries to accomplish this project. Their names along with reasons why used are listed below:
- Shared Preferences: I made use of this library to store the current theme of the app when the app is closed down
- Provider: I used provider as my general state management tool. Mostly used for the management of the Theme as well
- Google Fonts: I used the font Rubik for all Texts. I got access to it through this package
- Gradient Borders: I made use of this font to add nice gradient to the Expansion Tile Widgets present in the app
- Permission Handler: I made use of this package to retrieve permissions needed for the apps functionality, such as internet permissions
-  Simple Url Preview: This package assisted me in displaying web pages within or outside the application
- Url Launcher: This package assisted me in the launching of Url links in web pages or through apps
- Font Awesome: Font Awesome provided the icons of various social media platforms referenced in the app
- Video Player: I used this package to process and play videos present within the app
- Intl: This package is responsible for localization to different languages

<!-- # Challenges Faced
My Major challenge during this project was coming up with a design scheme and theme. I am used to working along side Product Designers who are usually responsible for this part. However, it was a much needed challenge to expose me into the world of design. I overcame this by watching alot of youtube videos on introduction to design. I also looked at the HNG design handbook posted on their twitter. -->

# Links and Files

The link to the apk can be foud [here](https://drive.google.com/drive/folders/1iXIpE2RxhAJMTwtcWZxI8ndY9YMdFGDg?usp=sharing), while the appetize link can be foud [here](https://appetize.io/app/brnppglssav3ogdhklefq3dtda?device=pixel4&osVersion=12.0&scale=75)



