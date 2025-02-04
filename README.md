# Movie Search App - Flutter

## Description
The Movie Search App allows users to search for movies, view movie details, and add movies to their favorites. The app integrates with the Movie Database (TMDb) API to fetch movie data. It features a clean UI/UX design.

## Features
- **Search for Movies**: Users can search movies by title.
- **Movie Results**: Displays a list of movie posters, titles, and release years.
- **Movie Details**: Detailed information on each movie (poster, title, release year, overview, rating).
- **Favorites**: Allows users to save their favorite movies.
- **Pagination**: Movie search results are paginated for better performance.rae

## Setup Instructions
1. **Clone the repository**:  
   Clone this repository to your local machine using the following command:
   ```bash
   git clone https://github.com/your-username/movie-search-app.git

2. **Install dependencies**:
    Navigate to the project folder and run:
    ```bash
    flutter pub get

3. **Obtain TMDb API Key**:
     -Sign up for a free account at TMDb.
     -Obtain your API key from the "API" section.
        -Create a .env file in the root of the project and add the API key:
    ```bash
    API_KEY=your_tmdb_api_key
    BASE_URL=https://api.themoviedb.org/3/movie/top_rated

4. **Run the app**:
    Run the app on an emulator or a physical device using the following command:
    ```bash
    flutter run

## Libraries/Plugins Used
    -hive: ^2.2.3 - For storing favorite movies locally in a lightweight NoSQL database.
    -hive_flutter: ^1.1.0 - For Flutter integration with Hive database.
    -http: ^1.2.2 - For making HTTP requests to the TMDb API.
    -provider: ^6.1.2 - For state management.
    -animated_text_kit: ^4.2.2 - For adding animated text to enhance user experience

## APK for Testing
You can download the APK file for testing from the following link:  
[Download APK](https://drive.google.com/file/d/19f38u2KXEvhXJp3Jn-XRzcLpQDUDKXpC/view?usp=drive_link)


