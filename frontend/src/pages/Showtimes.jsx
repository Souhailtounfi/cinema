import React, { useState, useEffect } from "react";
import { useParams, Link } from "react-router-dom";

const Showtimes = () => {
  const { movieId } = useParams();
  const [movie, setMovie] = useState(null);
  const [showtimes, setShowtimes] = useState([]);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    const fetchMovieAndShowtimes = async () => {
      try {
        // Fetch movie details
        const movieRes = await fetch(`http://localhost:8000/api/movies/${movieId}`);
        const movieData = await movieRes.json();
        setMovie(movieData);
        
        // Fetch showtimes for this movie
        const showtimesRes = await fetch(`http://localhost:8000/api/getShowtimes/${movieId}`);
        const showtimesData = await showtimesRes.json();
        setShowtimes(Array.isArray(showtimesData) ? showtimesData : []);
        
        setLoading(false);
      } catch (err) {
        console.error("Failed to fetch data:", err);
        setLoading(false);
      }
    };
    
    fetchMovieAndShowtimes();
  }, [movieId]);

  const formatDate = (dateString) => {
    const options = { weekday: 'short', year: 'numeric', month: 'short', day: 'numeric' };
    return new Date(dateString).toLocaleDateString('en-US', options);
  };

  if (loading) {
    return (
      <div className="min-h-screen bg-gray-900 pt-16 flex items-center justify-center">
        <div className="animate-spin rounded-full h-12 w-12 border-t-2 border-b-2 border-white"></div>
      </div>
    );
  }

  if (!movie) {
    return (
      <div className="min-h-screen bg-gray-900 pt-24 px-4 text-white text-center">
        <h2 className="text-2xl font-bold">Movie not found</h2>
        <p className="mt-4">The movie you're looking for doesn't exist or has been removed.</p>
        <Link to="/movies" className="mt-6 inline-block bg-blue-600 text-white px-4 py-2 rounded-lg">
          Back to Movies
        </Link>
      </div>
    );
  }

  return (
    <div className="min-h-screen bg-gray-900 pt-16">
      <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-12">
        <Link to="/movies" className="inline-flex items-center text-blue-300 hover:text-white mb-6">
          <svg xmlns="http://www.w3.org/2000/svg" className="h-5 w-5 mr-2" viewBox="0 0 20 20" fill="currentColor">
            <path fillRule="evenodd" d="M9.707 14.707a1 1 0 01-1.414 0l-4-4a1 1 0 010-1.414l4-4a1 1 0 011.414 1.414L7.414 9H15a1 1 0 110 2H7.414l2.293 2.293a1 1 0 010 1.414z" clipRule="evenodd" />
          </svg>
          Back to Movies
        </Link>
        
        <div className="bg-gray-800 rounded-xl overflow-hidden shadow-2xl">
          <div className="md:flex">
            <div className="md:w-1/3">
              <img 
                src={movie.poster_url} 
                alt={movie.title}
                className="w-full h-full object-cover" 
              />
            </div>
            <div className="p-6 md:w-2/3 flex flex-col text-white">
              <h1 className="text-3xl md:text-4xl font-bold mb-2">{movie.title}</h1>
              <div className="flex items-center mb-6">
                <span className="px-2 py-1 bg-gray-700 rounded-md text-sm mr-3">{movie.duration_minutes} mins</span>
                <span>Release Date: {formatDate(movie.release_date)}</span>
              </div>
              
              <p className="text-lg mb-8">{movie.description}</p>
              
              <div className="mt-auto">
                <h2 className="text-2xl font-bold mb-4">Available Showtimes</h2>
                {showtimes.length > 0 ? (
                  <div className="grid grid-cols-1 sm:grid-cols-2 md:grid-cols-3 gap-4">
                    {showtimes.map((showtime) => {
                      const formattedDate = new Date(showtime.show_date).toLocaleDateString("en-US", {
                        year: "numeric",
                        month: "short",
                        day: "numeric",
                      });
                      const formattedTime = showtime.show_time.slice(0, 5);

                      return (
                        <div
                          key={showtime.showtime_id}
                          className="bg-gray-700 p-4 rounded-lg"
                        >
                          <div className="space-y-3">
                            <h2 className="text-xl font-semibold">
                              {showtime.theater_name}
                            </h2>
                            <div className="flex items-center space-x-2">
                              <svg
                                className="w-5 h-5 text-gray-400"
                                fill="none"
                                stroke="currentColor"
                                viewBox="0 0 24 24"
                              >
                                <path
                                  strokeLinecap="round"
                                  strokeLinejoin="round"
                                  strokeWidth={2}
                                  d="M8 7V3m8 4V3m-9 8h10M5 21h14a2 2 0 002-2V7a2 2 0 00-2-2H5a2 2 0 00-2 2v12a2 2 0 002 2z"
                                />
                              </svg>
                              <span>{formattedDate}</span>
                            </div>
                            <div className="flex items-center space-x-2">
                              <svg
                                className="w-5 h-5 text-gray-400"
                                fill="none"
                                stroke="currentColor"
                                viewBox="0 0 24 24"
                              >
                                <path
                                  strokeLinecap="round"
                                  strokeLinejoin="round"
                                  strokeWidth={2}
                                  d="M12 8v4l3 3m6-3a9 9 0 11-18 0 9 9 0 0118 0z"
                                />
                              </svg>
                              <span className="font-medium">
                                {formattedTime}
                              </span>
                            </div>
                          </div>
                        </div>
                      );
                    })}
                  </div>
                ) : (
                  <p className="text-gray-400">No showtimes available for this movie.</p>
                )}
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  );
};

export default Showtimes;