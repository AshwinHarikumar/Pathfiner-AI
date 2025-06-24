# 🗺️ Pathfinder AI


Your personal AI guide to mastering any skill. Pathfinder AI generates dynamic, personalized learning roadmaps to help you navigate your educational journey from beginner to expert.

---

## ✨ Core Features

* **🤖 AI-Powered Roadmaps:** Leverages a powerful AI backend to generate step-by-step learning paths based on your goals, current experience, and existing skills.
* **👤 User Authentication:** Secure sign-in and sign-up functionality to save and manage your learning journeys.
* **🎨 Dynamic & Modern UI:** A clean, responsive, and beautifully designed interface built with Flutter, ensuring a seamless experience on both iOS and Android.
* **📝 Personalized Experience:** The generated path is tailored specifically to you, ensuring the learning curve is just right.
* **🚀 Scalable Backend:** Built with Supabase for robust authentication and data storage, and deployed on Render for reliable service.

## 📱 App Showcase

Here is a look at the core experience of Pathfinder AI, showcasing a generated learning path.

<p align="center">
  <img src="https://raw.githubusercontent.com/YourUsername/pathfinder_ai/main/screenshots/showcase.png" alt="Pathfinder AI App Screenshot" width="350"/>
</p>

## 🛠️ Tech Stack

| Component          | Technology                                                                                                                              |
| :----------------- | :-------------------------------------------------------------------------------------------------------------------------------------- |
| **Frontend** | ![Flutter](https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white)                                    |
| **State Management** | ![Riverpod](https://img.shields.io/badge/Riverpod-2.5.1-blue?style=for-the-badge)                                                       |
| **Backend Service** | ![Supabase](https://img.shields.io/badge/Supabase-36AD6A?style=for-the-badge&logo=supabase&logoColor=white)                               |
| **AI Integration** | ![Google AI](https://img.shields.io/badge/Google_AI-4285F4?style=for-the-badge&logo=google&logoColor=white)                                |
| **Deployment** | ![Render](https://img.shields.io/badge/Render-46E3B7?style=for-the-badge&logo=render&logoColor=white)                                      |

## 🚀 Getting Started

Follow these instructions to get the project up and running on your local machine for development and testing purposes.

### Prerequisites

* Flutter SDK (Version 3.19.0 or higher)
* An IDE like VS Code or Android Studio
* A Supabase account for backend services.

### Installation & Setup

1.  **Clone the repository:**
    ```sh
    git clone [https://github.com/YourUsername/pathfinder_ai.git](https://github.com/YourUsername/pathfinder_ai.git)
    cd pathfinder_ai
    ```

2.  **Install dependencies:**
    ```sh
    flutter pub get
    ```

3.  **Set up Environment Variables:**
    This project uses a `.env` file to manage sensitive keys for Supabase.
    * Create a file named `.env` in the root of the project.
    * Add your Supabase URL and Anon Key to this file. You can find these in your Supabase project's API settings.

    ```
    # .env file
    SUPABASE_URL=[https://your-project-url.supabase.co](https://your-project-url.supabase.co)
    SUPABASE_ANON_KEY=your-supabase-anon-key
    ```
    *(Note: This `.env` file is included in `.gitignore` to prevent it from being committed to the repository.)*

4.  **Run the app:**
    ```sh
    flutter run
    ```

## 📂 Project Structure

The project follows a feature-driven directory structure to maintain a clean and scalable codebase.