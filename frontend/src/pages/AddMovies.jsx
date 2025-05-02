import React, { useState } from "react";
import axios from "axios";
import { useNavigate } from "react-router-dom";
import bgImage from "../assets/bgImage.jpg";

function AddMovies() {
  const [form, setForm] = useState({
    title: "",
    description: "",
    duration: "",
    release_date: "",
    poster_url: "",
  });

  const navigate = useNavigate();

  const handleChange = (e) => {
    setForm({ ...form, [e.target.name]: e.target.value });
  };

  const handleSubmit = async (e) => {
    e.preventDefault();
    try {
      await axios.post("http://localhost:8000/api/addMovie", form);
      alert("Movie added successfully!");
      
    } catch (err) {
      console.error(err);
      alert("Movie Addition Failed!");
    }
  };

  return (
    <div
      className="flex items-center justify-center min-h-screen bg-cover bg-center"
      style={{ backgroundImage: `url(${bgImage})` }}
    >
      <div className="bg-white bg-opacity-80 backdrop-blur-md p-8 rounded-xl shadow-lg w-full max-w-md">
        <div className="text-center mb-6">
          <div className="text-4xl text-gray-600 mb-2">🎬</div>
          <h2 className="text-2xl font-bold">ADD MOVIE</h2>
        </div>

        <form onSubmit={handleSubmit} className="space-y-4">
          <input type="text" name="title" placeholder="Title" value={form.title} onChange={handleChange} required className="w-full p-2 border rounded" />
          <input type="text" name="description" placeholder="Description" value={form.description} onChange={handleChange} required className="w-full p-2 border rounded" />
          <input type="number" name="duration" placeholder="Duration (minutes)" value={form.duration} onChange={handleChange} required className="w-full p-2 border rounded" />
          <input type="date" name="release_date" value={form.release_date} onChange={handleChange} required className="w-full p-2 border rounded" />
          <input type="url" name="poster_url" placeholder="Poster URL" value={form.poster_url} onChange={handleChange} required className="w-full p-2 border rounded" />

          <button type="submit" className="w-full bg-cyan-600 text-white py-2 rounded hover:bg-cyan-700">
            ADD MOVIE
          </button>
          <button type="button" onClick={() => navigate("/movies")} className="w-full bg-gray-200 py-2 rounded mt-2">
            ← Go Back
          </button>
        </form>
      </div>
    </div>
  );
}

export default AddMovies;
