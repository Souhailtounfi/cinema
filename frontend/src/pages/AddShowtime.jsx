import React, { useState, useEffect } from "react";
import axios from "axios";

function AddShowtime() {
  const [form, setForm] = useState({ movie_id: "", theater_id: "", show_date: "", show_time: "" });
  const [movies, setMovies] = useState([]);
  const [theaters, setTheaters] = useState([]);
  const [errorMessage, setErrorMessage] = useState("");

  useEffect(() => {
    axios.get("http://localhost:8000/api/movies").then(res => setMovies(res.data));
    axios.get("http://localhost:8000/api/getTheater").then(res => setTheaters(res.data));
  }, []);

  const handleChange = (e) => {
    setForm({ ...form, [e.target.name]: e.target.value });
  };

  const handleSubmit = async (e) => {
    e.preventDefault();
    try {
      const res = await axios.post("http://localhost:8000/api/addShowtime", form);
      if (res.status === 201) {
        alert("Showtime added successfully!");
        setForm({ movie_id: "", theater_id: "", show_date: "", show_time: "" });
        setErrorMessage("");
      }
    } catch (error) {
      setErrorMessage(error?.response?.data?.message || "An unexpected error occurred.");
    }
  };

  return (
    <div className="flex items-center justify-center min-h-screen bg-gray-100">
      <div className="bg-white shadow-md rounded-lg p-8 w-full max-w-md">
        <div className="text-center mb-6">
          <div className="text-4xl text-gray-600 mb-2">📅</div>
          <h2 className="text-2xl font-bold">Add Showtime</h2>
        </div>

        <form onSubmit={handleSubmit} className="space-y-4">
          <select name="movie_id" value={form.movie_id} onChange={handleChange} required className="w-full p-2 border rounded">
            <option value="">Select Movie</option>
            {movies.map((movie) => (
              <option key={movie.id} value={movie.id}>{movie.title}</option>
            ))}
          </select>

          <select name="theater_id" value={form.theater_id} onChange={handleChange} required className="w-full p-2 border rounded">
            <option value="">Select Theater</option>
            {theaters.map((theater) => (
              <option key={theater.id} value={theater.id}>{theater.name}</option>
            ))}
          </select>

          <input type="date" name="show_date" value={form.show_date} onChange={handleChange} required className="w-full p-2 border rounded" />
          <input type="time" name="show_time" value={form.show_time} onChange={handleChange} required className="w-full p-2 border rounded" />

          {errorMessage && <div className="bg-red-100 text-red-600 p-2 rounded">{errorMessage}</div>}

          <button type="submit" className="w-full bg-cyan-600 text-white py-2 rounded hover:bg-cyan-700">
            Add Showtime
          </button>
        </form>
      </div>
    </div>
  );
}

export default AddShowtime;
