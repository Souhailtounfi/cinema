import React, { useEffect, useState } from "react";
import axios from "axios";
import { useParams, useNavigate } from "react-router-dom";

function EditMovie() {
  const { id } = useParams();
  const navigate = useNavigate();

  const [form, setForm] = useState({
    title: "",
    description: "",
    duration: "",
    release_date: "",
    poster_url: ""
  });

  useEffect(() => {
    axios.get(`http://localhost:8000/api/movies/${id}`).then((res) => {
      const movie = res.data;
      setForm({
        title: movie.title,
        description: movie.description,
        duration: movie.duration_minutes,
        release_date: movie.release_date,
        poster_url: movie.poster_url
      });
    }).catch(() => alert("Failed to load movie data"));
  }, [id]);

  const handleChange = (e) => {
    setForm({ ...form, [e.target.name]: e.target.value });
  };

  const handleSubmit = async (e) => {
    e.preventDefault();
    try {
      await axios.put(`http://localhost:8000/api/movies/${id}`, form);
      alert("Movie updated successfully");
      navigate("/movies");
    } catch {
      alert("Failed to update movie");
    }
  };

  return (
    <div className="flex justify-center items-center py-10 bg-gray-50 min-h-screen">
      <div className="bg-white p-8 shadow rounded-lg w-full max-w-md">
        <h3 className="text-center text-2xl font-bold mb-6">Edit Movie</h3>
        <form onSubmit={handleSubmit} className="space-y-4">
          <input type="text" name="title" value={form.title} onChange={handleChange} placeholder="Title" required className="w-full p-2 border rounded" />
          <input type="text" name="description" value={form.description} onChange={handleChange} placeholder="Description" required className="w-full p-2 border rounded" />
          <input type="number" name="duration" value={form.duration} onChange={handleChange} placeholder="Duration (minutes)" required className="w-full p-2 border rounded" />
          <input type="date" name="release_date" value={form.release_date} onChange={handleChange} required className="w-full p-2 border rounded" />
          <input type="url" name="poster_url" value={form.poster_url} onChange={handleChange} placeholder="Poster URL" required className="w-full p-2 border rounded" />

          <button type="submit" className="w-full bg-cyan-600 text-white py-2 rounded hover:bg-cyan-700">
            Update Movie
          </button>
          <button type="button" className="w-full bg-gray-300 py-2 rounded" onClick={() => navigate("/movies")}>
            Go Back
          </button>
        </form>
      </div>
    </div>
  );
}

export default EditMovie;
