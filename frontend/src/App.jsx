import { BrowserRouter, Routes, Route } from "react-router-dom";
import { AuthProvider } from "./context/AuthContext";
import Navbar from "./components/Navbar";
import Register from "./pages/Register";
import Login from "./pages/Login";
import Home from "./pages/Home";
import AddMovies from "./pages/AddMovies";
import AddShowtime from "./pages/AddShowtime";
import Theater from "./pages/Theater";
import MovieTable from "./pages/MovieTable";
import EditMovie from "./pages/EditMovie";
import Showtimes from "./pages/Showtimes";
import AddAdmin from "./pages/AddAdmin";
import Booking from "./pages/Booking";

function App() {
  return (
    <BrowserRouter>
      <AuthProvider>
        <Navbar />
        <Routes>
          <Route path="/" element={<Home />} />
          <Route path="/register" element={<Register />} />
          <Route path="/login" element={<Login />} />
          <Route path="/addAdmin" element={<AddAdmin />} />
          <Route path="/addMovies" element={<AddMovies />} />
          <Route path="/addShowtimes" element={<AddShowtime />} />
          <Route path="/addTheaters" element={<Theater />} />

          <Route path="/showtimes/:movieId" element={<Showtimes />} />
          <Route path="/movies" element={<MovieTable />} />
          <Route path="/editMovie/:id" element={<EditMovie />} />

          <Route path="/booking/:id" element={<Booking />} />
        </Routes>
      </AuthProvider>
    </BrowserRouter>
  );
}

export default App;
