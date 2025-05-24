import { useState } from 'react';
import { Link, useNavigate } from 'react-router-dom';
import axios from 'axios';

export default function AddAdmin() {
  const [formData, setFormData] = useState({
    name: '',
    email: '',
    password: '',
    role: 'admin'
  });
  const [error, setError] = useState('');
  const navigate = useNavigate();

  const handleSubmit = async (e) => {
    e.preventDefault();
    try {
      await axios.post('http://localhost:8000/api/register', formData);
      alert('Registration successful! Please login.');
      navigate('/login');
    } catch (err) {
      setError(err.response?.data?.message || 'Registration failed');
    }
  };

  return (
    <div className="max-w-md mx-auto mt-50 p-6 bg-white rounded shadow">
      <h2 className="text-2xl font-bold mb-6">Add Admin</h2>
      {error && <div className="text-red-500 mb-4">{error}</div>}
      
      <form onSubmit={handleSubmit}>
        <input
          type="text"
          name="name"
          placeholder="Name"
          required
          className="w-full p-2 mb-4 border rounded"
          onChange={(e) => setFormData({...formData, name: e.target.value})}
        />
        <input
          type="email"
          name="email"
          placeholder="Email"
          required
          className="w-full p-2 mb-4 border rounded"
          onChange={(e) => setFormData({...formData, email: e.target.value})}
        />
        <input
          type="password"
          name="password"
          placeholder="Password"
          required
          className="w-full p-2 mb-4 border rounded"
          onChange={(e) => setFormData({...formData, password: e.target.value})}
        />
        <button
          type="submit"
          className="w-full bg-blue-500 text-white py-2 rounded hover:bg-blue-600"
        >
          Register
        </button>
      </form>
      <div className="mt-4 text-center">
        Already have an account? <Link to="/login" className="text-blue-500">Login</Link>
      </div>
    </div>
  );
}