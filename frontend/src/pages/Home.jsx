import React, { useState, useEffect } from "react";
import { Link } from "react-router-dom";
import axios from "axios";
import { useAuth } from "../context/AuthContext";

function Home() {
  const [movies, setMovies] = useState([]);
  const [loading, setLoading] = useState(true);
  const [showAll, setShowAll] = useState(false);
  const { user } = useAuth();

  useEffect(() => {
    const fetchMovies = async () => {
      try {
        const res = await axios.get("http://localhost:8000/api/movies");
        setMovies(Array.isArray(res.data) ? res.data : []);
        setLoading(false);
      } catch (err) {
        console.error("Failed to fetch movies:", err);
        setLoading(false);
      }
    };

    fetchMovies();
  }, []);

  // Determine initial number of movies to show based on screen width
  const getInitialMovieCount = () => {
    if (typeof window !== "undefined") {
      if (window.innerWidth < 640) return 4; // Mobile
      if (window.innerWidth < 1024) return 6; // Tablet
      return 8; // Desktop
    }
    return 8;
  };

  const [initialMovieCount] = useState(getInitialMovieCount());
  const displayedMovies = showAll ? movies : movies.slice(0, initialMovieCount);

  return (
    <div className="min-h-screen bg-gradient-to-br from-blue-900 via-blue-800 to-indigo-900 text-white">
      {/* Hero Section (unchanged) */}
      <div className="pt-24 pb-20 px-4 sm:px-6 lg:px-8 flex flex-col items-center justify-center text-center">
        <div className="text-4xl md:text-6xl font-bold mb-4">
          {user && <span>Hello, {user.name}</span>}
        </div>

        <h1 className="text-4xl md:text-6xl font-bold mb-4">
          Welcome to Mazagan Screenverse
        </h1>
        <p className="text-xl md:text-2xl text-blue-200 max-w-3xl mb-8">
          Your premier destination for the latest movies and seamless ticket
          booking experience.
        </p>
        <div className="flex space-x-4">
          {user?.role === "admin" && (
            <Link
              to="/movies"
              className="bg-blue-600 hover:bg-blue-700 text-white px-6 py-3 rounded-lg font-medium transition"
            >
              Browse Movies
            </Link>
          )}

          <Link
            to="/login"
            className="bg-purple-600 hover:bg-purple-700 text-white px-6 py-3 rounded-lg font-medium transition"
          >
            Book Tickets
          </Link>
        </div>
      </div>

      {/* Featured Movies */}
      <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-16">
        <h2 className="text-3xl font-bold mb-10 text-center">
          Featured Movies
        </h2>
        {loading ? (
          <div className="flex justify-center">
            <div className="animate-spin rounded-full h-12 w-12 border-t-2 border-b-2 border-white"></div>
          </div>
        ) : (
          <>
            <div className="grid grid-cols-2 sm:grid-cols-3 lg:grid-cols-4 gap-8">
              {displayedMovies.length > 0 ? (
                displayedMovies.map((movie) => (
                  <Link
                    to={`/showtimes/${movie.id}`}
                    key={movie.id}
                    className="movie-card group"
                  >
                    <div className="relative aspect-[2/3] overflow-hidden">
                      <img
                        src={movie.poster_url}
                        alt={movie.title}
                        className="w-full h-full object-cover transition-transform group-hover:scale-110"
                      />
                      <div className="absolute inset-0 bg-gradient-to-t from-black via-transparent opacity-70"></div>
                      <div className="absolute bottom-0 left-0 right-0 p-4">
                        <h3 className="text-xl font-bold mb-1">
                          {movie.title}
                        </h3>
                        <p className="text-sm text-gray-300">
                          {movie.duration_minutes} mins
                        </p>
                      </div>
                    </div>
                  </Link>
                ))
              ) : (
                <div className="col-span-full text-center text-gray-300">
                  <p className="text-xl">No movies available at this time.</p>
                  <p className="mt-2">Check back soon for updates!</p>
                </div>
              )}
            </div>
            {movies.length > initialMovieCount && (
              <div className="text-center mt-10">
                <button
                  onClick={() => setShowAll(!showAll)}
                  className="inline-block bg-blue-600 hover:bg-blue-700 text-white px-6 py-3 rounded-lg font-medium transition"
                >
                  {showAll ? "Show Less" : "Show All Movies"}
                </button>
              </div>
            )}
          </>
        )}
      </div>

      <div className="bg-blue-950 py-16">
        <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
          <h2 className="text-3xl font-bold mb-12 text-center">How It Works</h2>
          <div className="grid grid-cols-1 md:grid-cols-3 gap-8">
            <div className="text-center p-6">
              <div className="text-5xl mb-4 flex justify-center">🎬</div>
              <h3 className="text-xl font-bold mb-2">Browse Movies</h3>
              <p className="text-blue-200">
                Explore our selection of the latest blockbusters and timeless
                classics.
              </p>
            </div>
            <div className="text-center p-6">
              <div className="text-5xl mb-4 flex justify-center">🎟️</div>
              <h3 className="text-xl font-bold mb-2">Select Seats</h3>
              <p className="text-blue-200">
                Choose your preferred seats from our interactive seating chart.
              </p>
            </div>
            <div className="text-center p-6">
              <div className="text-5xl mb-4 flex justify-center">✅</div>
              <h3 className="text-xl font-bold mb-2">Confirm Booking</h3>
              <p className="text-blue-200">
                Complete your booking and receive instant confirmation.
              </p>
            </div>
          </div>
        </div>
      </div>

      {/* Footer */}
      <footer className="bg-blue-950 border-t border-blue-800 py-8">
        <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
          <div className="text-center">
            <h2 className="text-2xl font-bold mb-2">Mazagan Screenverse</h2>
            <p className="text-blue-300 mb-4">The ultimate movie experience</p>
            <div className="flex justify-center space-x-4">
              <a href="#" className="text-blue-300 hover:text-white">
                Terms & Conditions
              </a>
              <a href="#" className="text-blue-300 hover:text-white">
                Privacy Policy
              </a>
              <a href="#" className="text-blue-300 hover:text-white">
                Contact Us
              </a>
            </div>
            <p className="mt-6 text-sm text-blue-400">
              © {new Date().getFullYear()} Mazagan SCREENVERSE. All rights
              reserved.
            </p>
          </div>
        </div>
      </footer>
    </div>
  );
}

export default Home;
