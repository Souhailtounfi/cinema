import React, { useState, useEffect } from "react";
import axios from "axios";
import bgImage from "../assets/bgImage.jpg";

function Theater() {
  const [theaters, setTheaters] = useState([]);
  const [form, setForm] = useState({
    name: "",
    capacity: "",
  });

  // Fetch theaters on component mount
  useEffect(() => {
    fetchTheaters();
  }, []);

  const handleChange = (e) => {
    setForm({ ...form, [e.target.name]: e.target.value });
  };

  const handleSubmit = async (e) => {
    e.preventDefault();
    try {
      const res = await axios.post(
        "http://localhost:8000/api/addTheater",
        form
      );
      if (res.status === 201 || res.status === 200) {
        alert("Theater added successfully!");
        setForm({ name: "", capacity: "" });
        fetchTheaters(); // Refresh the list after adding
      }
    } catch (err) {
      console.error(err);
      alert(err.response?.data?.message || "Theater addition failed!");
    }
  };

  const fetchTheaters = async () => {
    try {
      const res = await axios.get("http://localhost:8000/api/getTheater");
      setTheaters(res.data);
    } catch (err) {
      console.error("Failed to fetch theaters:", err);
      alert("Failed to load theaters");
    }
  };

  return (
    <div
      className="flex items-center justify-center min-h-screen bg-cover bg-center px-4 py-8"
      style={{
        backgroundImage: `url(${bgImage})`,
      }}>
      <div className="max-w-4xl w-full mx-auto">
        {/* Add Theater Form - Now on top */}
        <div className="bg-white/80 backdrop-blur-md rounded-xl shadow-xl p-8 mb-8 w-full">
          <div className="text-center mb-6">
            <div className="text-4xl text-teal-600 mb-2">🎬</div>
            <h2 className="text-2xl font-bold">Add Theater</h2>
          </div>
          <form onSubmit={handleSubmit}>
            <input
              type="text"
              name="name"
              placeholder="Theater Name"
              value={form.name}
              onChange={handleChange}
              required
              className="w-full px-4 py-2 mb-4 border rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-400"
            />
            <input
              type="number"
              name="capacity"
              placeholder="Seat Capacity (Between 15-390)"
              min="10"
              value={form.capacity}
              onChange={handleChange}
              required
              className="w-full px-4 py-2 mb-4 border rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-400"
            />
            <button
              type="submit"
              className="w-full bg-blue-500 text-white py-2 rounded-lg hover:bg-blue-600 transition"
            >
              Add Theater
            </button>
          </form>
        </div>

        {/* Theater Table Section - Now on bottom */}
        <div className="bg-white/80 backdrop-blur-md rounded-xl shadow-xl p-6 w-full">
          <h4 className="text-xl font-bold text-center p-4 border-b">
            All Theaters
          </h4>
          <div className="overflow-x-auto">
            <table className="w-full text-sm text-left">
              <thead className="bg-gray-200 text-gray-700">
                <tr>
                  <th className="p-3">Theater</th>
                  <th className="p-3">Capacity</th>
                  <th className="p-3">Seat Rows</th>
                </tr>
              </thead>
              <tbody>
                {theaters.length > 0 ? (
                  theaters.map((theater) => (
                    <tr key={theater.id} className="border-t hover:bg-gray-50">
                      <td className="p-3">{theater.name}</td>
                      <td className="p-3">{theater.capacity}</td>
                      <td className="p-3">
                        {theater.capacity ? 
                          `A-${String.fromCharCode(64 + Math.ceil(theater.capacity/15))}` : 
                          'N/A'}
                      </td>
                    </tr>
                  ))
                ) : (
                  <tr>
                    <td className="p-4 text-center text-gray-500" colSpan="3">
                      No theaters found.
                    </td>
                  </tr>
                )}
              </tbody>
            </table>
          </div>
        </div>
      </div>
    </div>
  );
}

export default Theater;