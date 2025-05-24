import React, { useEffect, useState } from "react";
import axios from "axios";
import { useNavigate } from "react-router-dom";

function MovieTable() {
  const [movies, setMovies] = useState([]);
  const [searchTerm, setSearchTerm] = useState("");
  const navigate = useNavigate();

  const fetchMovies = async () => {
    try {
      const res = await axios.get("http://localhost:8000/api/movies");
      console.log("Fetched movies:", res.data); // Debug log

      // Adjust based on response structure
      const data = Array.isArray(res.data) ? res.data : res.data.movies || [];
      setMovies(data);
    } catch (err) {
      console.error("Failed to fetch movies:", err);
    }
  };

  const handleDelete = async (id) => {
    if (!window.confirm("Delete this movie?")) return;
    try {
      await axios.delete(`http://localhost:8000/api/movies/${id}`);
      fetchMovies();
    } catch (err) {
      console.error("Delete failed:", err);
      alert("Deletion failed");
    }
  };

  useEffect(() => {
    fetchMovies();
  }, []);

  const filteredMovies = movies.filter((movie) =>
    movie.title?.toLowerCase().includes(searchTerm.toLowerCase())
  );

  return (
    <div className="min-h-screen bg-gradient-to-br from-purple-600 via-purple-500 to-indigo-500 text-white pt-40 px-6">
      <div className="max-w-7xl mx-auto">
        {/* Search & Add Movie */}
        <div className="flex flex-col md:flex-row justify-between items-center mb-6 gap-4">
          <input
            type="text"
            placeholder="Search by Title"
            value={searchTerm}
            onChange={(e) => setSearchTerm(e.target.value)}
            className="px-4 py-2 rounded-lg w-full md:w-1/2 text-black bg-white hover:bg-purple-200 transition"
          />

          <button
            onClick={() => navigate("/addMovies")}
            className="bg-green-500 px-6 py-2 rounded-lg hover:bg-green-600 transition"
          >
            + Add Movie
          </button>
        </div>

        {/* Movie Count Info */}
        <div className="mb-4 p-3 bg-white/20 rounded-lg">
          <p className="text-lg font-semibold">
            Showing {filteredMovies.length} {filteredMovies.length === 1 ? "movie" : "movies"}
            {searchTerm && ` matching "${searchTerm}"`}
          </p>
          {searchTerm && filteredMovies.length < movies.length && (
            <p className="text-sm opacity-80">
              (from total of {movies.length} movies)
            </p>
          )}
        </div>

        {/* Movie Table */}
        <div className="bg-white text-black rounded-lg overflow-auto shadow-lg">
          <h4 className="text-xl font-bold text-center p-4 border-b">
            All Movies
          </h4>
          <table className="w-full text-sm text-left">
            <thead className="bg-gray-200 text-gray-700">
              <tr>
                <th className="p-3">Poster</th>
                <th className="p-3">Title</th>
                <th className="p-3">Description</th>
                <th className="p-3">Duration</th>
                <th className="p-3">Release Date</th>
                <th className="p-3">Actions</th>
              </tr>
            </thead>
            <tbody>
              {filteredMovies.length > 0 ? (
                filteredMovies.map((movie) => (
                  <tr key={movie.id} className="border-t">
                    <td className="p-3">
                      <img
                        src={movie.poster_url}
                        alt={movie.title}
                        className="h-auto object-cover w-30"
                      />
                    </td>
                    <td className="p-3">{movie.title}</td>
                    <td className="p-3">{movie.description}</td>
                    <td className="p-3">{movie.duration_minutes} min</td>
                    <td className="p-3">{movie.release_date}</td>
                    <td className="p-3 align-middle">
                      <div className="flex flex-col md:flex-row gap-2 justify-center">
                        <button
                          onClick={() => navigate(`/editMovie/${movie.id}`)}
                          className="bg-yellow-500 px-4 py-2 rounded hover:bg-yellow-600"
                        >
                          Edit
                        </button>
                        <button
                          onClick={() => handleDelete(movie.id)}
                          className="bg-red-500 px-4 py-2 rounded hover:bg-red-600"
                        >
                          Delete
                        </button>
                      </div>
                    </td>
                  </tr>
                ))
              ) : (
                <tr>
                  <td className="p-4 text-center text-gray-500" colSpan="6">
                    No movies found.
                  </td>
                </tr>
              )}
            </tbody>
          </table>
        </div>
      </div>
    </div>
  );
}

export default MovieTable;