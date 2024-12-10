# SuCasa: AI-Powered Interior Designing App

SuCasa is an AI-powered mobile application that redefines how users explore and create personalized interior designs. The app integrates advanced AI tools to enhance room images, provide tailored recommendations, and offer seamless user interactions.

---

## Features

### Core Features
- **Room Image Upload or Capture**: Users can upload an image of a room or capture one using the camera.
- **AI Image Enhancement**: The app processes images using the Gemini model to enhance them with advanced AI techniques.
- **Feature Extraction**: Extract multiple features like objects, segmentation, and depth from images.
- **Personalized Design Recommendations**: Receive interior design suggestions based on extracted features and user preferences.
- **Budget Forecasting Tools**: Plan your designs within your budget with integrated forecasting.

### Additional Features
- **Interactive User Interface**: A clean, intuitive, and responsive UI powered by Flutter.
- **Save and Share**: Save enhanced images to your device or share them with others.
- **Cloud Integration**: Securely store and retrieve enhanced images using Firebase.
- **Real-Time AI Prompt Generation**: Automatically generate prompts for the Gemini model to optimize design outputs.

---

## Technologies Used

### Frontend
- **Flutter**: Cross-platform mobile application development.
- **camera.dart**: Manage camera functionality for capturing room images.

### Backend
- **Firebase**: For backend storage and authentication.
- **Google ML Kit**: Feature extraction from images, including object detection and segmentation.
- **OpenAI's DALL·E**: Generate enhanced images based on extracted features and user prompts.

---

## Installation and Setup

### Prerequisites
- [Flutter SDK](https://flutter.dev/)
- [Firebase CLI](https://firebase.google.com/docs/cli)

### Steps
1. Clone the repository:
   ```bash
   git clone https://github.com/your-username/sucasa.git
   cd sucasa

