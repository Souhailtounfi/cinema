import React, { useState, useEffect } from "react";
import { useParams, Link } from "react-router-dom";

const Showtimes = () => {
  const { movieId } = useParams();
  const [movie, setMovie] = useState(null);
  const [showtimes, setShowtimes] = useState([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(null);

  useEffect(() => {
    const fetchData = async () => {
      try {
        setLoading(true);
        const movieRes = await fetch(`http://localhost:8000/api/movies/${movieId}`);
        if (!movieRes.ok) throw new Error("Movie not found");
        const movieData = await movieRes.json();
        setMovie(movieData);

        const showtimesRes = await fetch(`http://localhost:8000/api/getShowtimes/${movieId}`);
        const showtimesData = await showtimesRes.json();
        setShowtimes(Array.isArray(showtimesData) ? showtimesData : []);
      } catch (err) {
        setError(err.message);
        console.error(err);
      } finally {
        setLoading(false);
      }
    };

    fetchData();
  }, [movieId]);

  const formatDate = (dateString) =>
    new Date(dateString).toLocaleDateString("en-US", {
      weekday: "short",
      month: "short",
      day: "numeric",
    });

  if (loading) {
    return (
      <div className="min-h-screen bg-gray-900 flex items-center justify-center">
        <div className="animate-spin h-12 w-12 border-t-2 border-white rounded-full"></div>
      </div>
    );
  }

  if (error) {
    return (
      <div className="min-h-screen bg-gray-900 text-white flex flex-col items-center justify-center p-4">
        <h2 className="text-2xl font-bold mb-4">{error}</h2>
        <Link to="/movies" className="px-4 py-2 bg-blue-600 rounded hover:bg-blue-700 transition">
          Back to Movies
        </Link>
      </div>
    );
  }

  return (
    <div className="min-h-screen bg-gray-900 text-white pt-20 pb-10 px-4">
      <div className="max-w-4xl mx-auto">
        <div className="flex flex-col md:flex-row gap-6 mb-8 p-4 bg-gray-800 rounded-lg">
          <img
            src={movie.poster_url}
            alt={movie.title}
            className="w-full md:w-1/3 rounded-lg object-cover"
          />
          <div>
            <h1 className="text-3xl font-bold mb-2">{movie.title}</h1>
            <p className="text-gray-300 mb-4">{movie.description}</p>
            <div className="flex flex-wrap items-center gap-4 mb-4">
              <span className="px-3 py-1 bg-gray-700 rounded-full text-sm">
                {movie.duration_minutes} min
              </span>
              <span className="text-gray-300">
                Release: {new Date(movie.release_date).toLocaleDateString()}
              </span>
            </div>
            {movie.trailer_url && (
              <a
                href={movie.trailer_url}
                target="_blank"
                rel="noopener noreferrer"
                className="inline-block px-4 py-2 bg-red-600 hover:bg-red-700 text-white rounded transition"
              >
                Watch Trailer
              </a>
            )}
          </div>
        </div>

        <h2 className="text-2xl font-bold mb-6">Available Showtimes</h2>

        {showtimes.length > 0 ? (
          <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-4">
            {showtimes.map((showtime) => (
              <Link
                key={showtime.showtime_id}
                to={`/booking/${showtime.showtime_id}`}
                state={{
                  movie_poster: movie.poster_url,
                  movie_title: movie.title,
                  date: showtime.show_date,
                  time: showtime.show_time,
                  theater: showtime.theater_name,
                  duration: movie.duration_minutes,
                }}
                className="block p-4 bg-purple-900 rounded-lg hover:bg-green-800 transition border border-gray-700"
              >
                <div className="flex items-center gap-2 text-gray-300 font-bold text-2xl">
                  <svg className="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path
                      strokeLinecap="round"
                      strokeLinejoin="round"
                      strokeWidth={2}
                      d="M8 7V3m8 4V3m-9 8h10M5 21h14a2 2 0 002-2V7a2 2 0 00-2-2H5a2 2 0 00-2 2v12a2 2 0 002 2z"
                    />
                  </svg>
                  <span>{formatDate(showtime.show_date)}</span>
                </div>

                <div className="flex items-center gap-2 text-gray-300 mt-1 text-xl">
                  <svg className="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path
                      strokeLinecap="round"
                      strokeLinejoin="round"
                      strokeWidth={2}
                      d="M12 8v4l3 3m6-3a9 9 0 11-18 0 9 9 0 0118 0z"
                    />
                  </svg>
                  <span>{showtime.show_time.slice(0, 5)}</span>
                </div>

                <h3 className="text-xl mb-2">{showtime.theater_name}</h3>
              </Link>
            ))}
          </div>
        ) : (
          <div className="bg-gray-800 rounded-lg p-6 text-center">
            <p className="text-gray-400">No showtimes available for this movie</p>
          </div>
        )}
      </div>
    </div>
  );
};

export default Showtimes;
