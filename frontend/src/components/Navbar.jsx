import { useState } from "react";
import { Link, useNavigate } from "react-router-dom";
import { useAuth } from "../context/AuthContext"; // Fixed import path

function Navbar() {
  const [isMobileMenuOpen, setIsMobileMenuOpen] = useState(false);
  const navigate = useNavigate();
  const { user, logout } = useAuth(); // Now properly imported

  return (
    <nav className="bg-gradient-to-r from-blue-900 to-purple-900 text-white shadow-md fixed top-0 w-full z-50">
      <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        <div className="flex justify-between h-16">
          <div className="flex items-center">
            <Link to="/" className="flex items-center">
              <span className="text-2xl font-bold mr-2">🎬</span>
              <span className="font-bold text-xl">Mazagan Screenverse</span>
            </Link>
          </div>

          {/* Desktop menu */}
          <div className="hidden md:flex items-center space-x-4">
            <Link
              to="/"
              className="px-3 py-2 rounded-md hover:bg-blue-800 transition"
            >
              Home
            </Link>

            {user?.role === "admin" && (
              <>
                <Link
                  to="/AddAdmin"
                  className="px-3 py-2 rounded-md hover:bg-blue-800 transition"
                >
                  Add Admin
                </Link>
                <Link
                  to="/movies"
                  className="px-3 py-2 rounded-md hover:bg-blue-800 transition"
                >
                  Movies
                </Link>
                <Link
                  to="/addShowtimes"
                  className="px-3 py-2 rounded-md hover:bg-blue-800 transition"
                >
                  Add Showtime
                </Link>
                <Link
                  to="/addTheaters"
                  className="px-3 py-2 rounded-md hover:bg-blue-800 transition"
                >
                  Add Theater
                </Link>
              </>
            )}

            {user ? (
              <button
                onClick={() => {
                  logout();
                  navigate("/login");
                }}
                className="px-3 py-2 bg-red-600 rounded-md hover:bg-red-700 transition"
              >
                Logout
              </button>
            ) : (
              <div className="flex space-x-2">
                <Link
                  to="/login"
                  className="px-3 py-2 bg-blue-700 rounded-md hover:bg-blue-800 transition"
                >
                  Login
                </Link>
                <Link
                  to="/register"
                  className="px-3 py-2 bg-purple-700 rounded-md hover:bg-purple-800 transition"
                >
                  Register
                </Link>
              </div>
            )}
          </div>

          {/* Mobile menu button */}
          <div className="md:hidden flex items-center">
            <button
              onClick={() => setIsMobileMenuOpen(!isMobileMenuOpen)}
              className="p-2 rounded-md hover:bg-blue-800"
              aria-label="Toggle menu"
            >
              {isMobileMenuOpen ? (
                <svg
                  className="h-6 w-6"
                  fill="none"
                  viewBox="0 0 24 24"
                  stroke="currentColor"
                >
                  <path
                    strokeLinecap="round"
                    strokeLinejoin="round"
                    strokeWidth={2}
                    d="M6 18L18 6M6 6l12 12"
                  />
                </svg>
              ) : (
                <svg
                  className="h-6 w-6"
                  fill="none"
                  viewBox="0 0 24 24"
                  stroke="currentColor"
                >
                  <path
                    strokeLinecap="round"
                    strokeLinejoin="round"
                    strokeWidth={2}
                    d="M4 6h16M4 12h16M4 18h16"
                  />
                </svg>
              )}
            </button>
          </div>
        </div>
      </div>

      {/* Mobile menu */}
      {isMobileMenuOpen && (
        <div className="md:hidden bg-blue-950 pb-3 px-2 space-y-1">
          <Link
            to="/AddAdmin"
            className="px-3 py-2 rounded-md hover:bg-blue-800 transition"
          >
            Add Admin
          </Link>
          <Link
            to="/"
            className="block px-3 py-2 rounded-md hover:bg-blue-800 transition"
          >
            Home
          </Link>
          {user?.role === "admin" && (
            <>
              <Link
                to="/movies"
                className="block px-3 py-2 rounded-md hover:bg-blue-800 transition"
              >
                Movies
              </Link>
              <Link
                to="/addShowtimes"
                className="block px-3 py-2 rounded-md hover:bg-blue-800 transition"
              >
                Add Showtime
              </Link>
              <Link
                to="/addTheaters"
                className="block px-3 py-2 rounded-md hover:bg-blue-800 transition"
              >
                Add Theater
              </Link>
            </>
          )}

          {user ? (
            <button
              onClick={() => {
                logout();
                navigate("/login");
              }}
              className="block w-full text-left px-3 py-2 bg-red-600 rounded-md hover:bg-red-700 transition"
            >
              Logout
            </button>
          ) : (
            <div className="space-y-1">
              <Link
                to="/login"
                className="block px-3 py-2 bg-blue-700 rounded-md hover:bg-blue-800 transition"
              >
                Login
              </Link>
              <Link
                to="/register"
                className="block px-3 py-2 bg-purple-700 rounded-md hover:bg-purple-800 transition"
              >
                Register
              </Link>
            </div>
          )}
        </div>
      )}
    </nav>
  );
}

export default Navbar;
