# MBC Survey Browser Application

## Overview

This application allows users to browse and take surveys on their mobile devices. It requires user authentication and provides a seamless experience for accessing various surveys with an intuitive user interface.

Log in - Your_email@example.com
Password - 12345678

## Features

### Authentication
- **Login Screen**: A dedicated screen where users can log in to access surveys. ✅
- **OAuth Integration**: Secure authentication using OAuth 2 API, with access token storage. ✅
- **Refresh Tokens**: Automatic usage of refresh tokens to maintain user sessions. ✅

### Home Screen
- **Survey Display**: Each survey is presented as a card showing its cover image, name in bold, and a brief description. ✅
- **Survey Browsing**: Users can horizontally scroll through survey cards. ✅
- **Taking Surveys**: A “Take Survey” button on each card to start the survey. ✅

### Data Fetching
- **API Integration**: Surveys are fetched upon application launch. ✅
- **Loading State**: Display a loading animation while surveys are being loaded. ✅
- **Dynamic Navigation**: Display navigation bullets dynamically based on API responses. ✅

### Optional Features
- **Password Recovery**: A screen to recover forgotten passwords. ✅
- **Survey Caching**: Save survey data locally for offline access. ✅ (Only information, not images)
- **Update Mechanism**: A pull-to-refresh gesture to update the survey list with a loading animation. ✅ (Vertical)

## Technical Requirements

- **Development Environment**: Use Xcode - Swift. ✅
- **Platform Support**: Ensure compatibility with iOS 10.0 and above. ✅
- **Version Control**: Use Git for source control management and push to a public repository on Bitbucket, GitHub, or GitLab with regular commits and pull requests. ✅
- **Testing**: Write unit tests for the application using a preferred testing framework. 🛑
- **API Usage**: REST endpoints and use production URLs for the API calls. ✅
