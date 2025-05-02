import { BrowserRouter, Routes, Route } from 'react-router-dom';
import Navbar from "./components/Navbar.jsx";
import Register from './pages/Register';
import Login from './pages/Login';
import Home from './pages/Home';
import AddMovies from './pages/AddMovies';
import AddShowtime from './pages/AddShowtime';
import Theater from './pages/Theater';
import MovieTable from './pages/MovieTable';
import EditMovie from './pages/EditMovie';
import Booking from './pages/Booking.jsx';
import Showtimes from './pages/Showtimes.jsx';

function App() {
  return (
    <BrowserRouter>
      <Navbar />
      
      <Routes>
        <Route path="/" element={<Home />} />
        <Route path="/register" element={<Register />} />
        <Route path="/login" element={<Login />} />
        <Route path="/addMovies" element={<AddMovies />} />
        <Route path="/addShowtime" element={<AddShowtime />} />
        <Route path="/showtimes/:movieId" element={<Showtimes />} />
        <Route path="/theaters" element={<Theater />} />
        <Route path="/movies" element={<MovieTable />} />
        <Route path="/editMovie/:id" element={<EditMovie />} />
        <Route path="/booking" element={<Booking />} />
      </Routes>
    </BrowserRouter>
  );
}

export default App;
