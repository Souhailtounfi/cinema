import React, { useState, useEffect } from "react";
import { useParams, useNavigate } from "react-router-dom";
import axios from "axios";

function Booking() {
  const { id: showtimeId } = useParams();
  const navigate = useNavigate();
  
  const [showtime, setShowtime] = useState(null);
  const [movie, setMovie] = useState(null);
  const [theater, setTheater] = useState(null);
  const [selectedSeats, setSelectedSeats] = useState([]);
  const [bookedSeats, setBookedSeats] = useState([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(null);

  const rows = ['A', 'B', 'C', 'D', 'E', 'F', 'G', 'H'];
  const seatsPerRow = 10;
  const ticketPrice = 12.99;
  
  useEffect(() => {
    const token = localStorage.getItem("token");
    if (!token) {
      navigate("/login");
      return;
    }
    
    const fetchShowtimeDetails = async () => {
      try {
        // Fetch showtime details
        const showtimeRes = await axios.get(`http://localhost:8000/api/showtimes/${showtimeId}`);
        setShowtime(showtimeRes.data);
        
        // Fetch movie details
        const movieRes = await axios.get(`http://localhost:8000/api/movies/${showtimeRes.data.movie_id}`);
        setMovie(movieRes.data);
        
        // Fetch theater details
        const theaterRes = await axios.get(`http://localhost:8000/api/theaters/${showtimeRes.data.theater_id}`);
        setTheater(theaterRes.data);
        
        // Fetch booked seats for this showtime
        const bookingsRes = await axios.get(`http://localhost:8000/api/bookings/showtime/${showtimeId}`);
        const bookedSeatsData = bookingsRes.data.flatMap(booking => booking.seats || []);
        setBookedSeats(bookedSeatsData);
        
        setLoading(false);
      } catch (err) {
        console.error("Failed to fetch showtime data:", err);
        setError("Failed to load booking information. Please try again.");
        setLoading(false);
      }
    };
    
    fetchShowtimeDetails();
  }, [showtimeId, navigate]);

  const toggleSeat = (seat) => {
    if (bookedSeats.includes(seat)) return; // Can't select already booked seats
    
    setSelectedSeats(prev => 
      prev.includes(seat)
        ? prev.filter(s => s !== seat)
        : [...prev, seat]
    );
  };

  const isSeatSelected = (seat) => selectedSeats.includes(seat);
  const isSeatBooked = (seat) => bookedSeats.includes(seat);

  const formatDate = (dateString) => {
    if (!dateString) return '';
    const options = { weekday: 'long', year: 'numeric', month: 'long', day: 'numeric' };
    return new Date(dateString).toLocaleDateString('en-US', options);
  };

  const formatTime = (timeString) => {
    if (!timeString) return '';
    return new Date(`2000-01-01T${timeString}`).toLocaleTimeString([], { 
      hour: '2-digit', 
      minute: '2-digit' 
    });
  };

  const handleBooking = async () => {
    if (selectedSeats.length === 0) {
      alert("Please select at least one seat.");
      return;
    }
    
    try {
      const token = localStorage.getItem("token");
      const response = await axios.post(
        "http://localhost:8000/api/bookings",
        {
          showtime_id: showtimeId,
          seats: selectedSeats,
          total_price: (selectedSeats.length * ticketPrice).toFixed(2)
        },
        {
          headers: { Authorization: `Bearer ${token}` }
        }
      );
      
      alert("Booking successful!");
      navigate(`/confirmation/${response.data.id}`);
    } catch (err) {
      console.error("Booking failed:", err);
      alert("Failed to complete booking. Please try again.");
    }
  };

  if (loading) {
    return (
      <div className="min-h-screen cinema-gradient pt-16 flex items-center justify-center">
        <div className="animate-spin rounded-full h-12 w-12 border-t-2 border-b-2 border-white"></div>
      </div>
    );
  }

  if (error) {
    return (
      <div className="min-h-screen cinema-gradient pt-24 px-4 text-white text-center">
        <h2 className="text-2xl font-bold">Error</h2>
        <p className="mt-4">{error}</p>
        <button 
          onClick={() => navigate(-1)}
          className="mt-6 bg-blue-600 text-white px-4 py-2 rounded-lg"
        >
          Go Back
        </button>
      </div>
    );
  }

  if (!showtime || !movie || !theater) {
    return (
      <div className="min-h-screen cinema-gradient pt-24 px-4 text-white text-center">
        <h2 className="text-2xl font-bold">Information not available</h2>
        <p className="mt-4">We couldn't find the booking details you're looking for.</p>
        <button 
          onClick={() => navigate(-1)}
          className="mt-6 bg-blue-600 text-white px-4 py-2 rounded-lg"
        >
          Go Back
        </button>
      </div>
    );
  }

  return (
    <div className="min-h-screen cinema-gradient pt-16 pb-12">
      <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-8 text-white">
        <button 
          onClick={() => navigate(-1)}
          className="inline-flex items-center text-blue-300 hover:text-white mb-6"
        >
          <svg xmlns="http://www.w3.org/2000/svg" className="h-5 w-5 mr-2" viewBox="0 0 20 20" fill="currentColor">
            <path fillRule="evenodd" d="M9.707 14.707a1 1 0 01-1.414 0l-4-4a1 1 0 010-1.414l4-4a1 1 0 011.414 1.414L7.414 9H15a1 1 0 110 2H7.414l2.293 2.293a1 1 0 010 1.414z" clipRule="evenodd" />
          </svg>
          Back
        </button>
        
        <div className="bg-blue-900 bg-opacity-50 backdrop-blur-md rounded-xl shadow-2xl overflow-hidden">
          <div className="p-6">
            <h1 className="text-2xl md:text-3xl font-bold mb-2">Select Your Seats</h1>
            <div className="flex flex-wrap items-center gap-2 mb-6">
              <span className="font-bold">{movie.title}</span>
              <span className="text-blue-300">•</span>
              <span>{formatDate(showtime.show_date)}</span>
              <span className="text-blue-300">•</span>
              <span>{formatTime(showtime.show_time)}</span>
              <span className="text-blue-300">•</span>
              <span>{theater.name}</span>
            </div>
            
            <div className="bg-blue-950 p-4 rounded-lg mb-8">
              <div className="flex justify-center mb-6">
                <div className="screen"></div>
              </div>
              
              <div className="flex justify-center mb-6">
                {/* Seat Legend */}
                <div className="flex space-x-8">
                  <div className="flex items-center">
                    <div className="seat seat-available w-6 h-6 mr-2"></div>
                    <span className="text-sm">Available</span>
                  </div>
                  <div className="flex items-center">
                    <div className="seat seat-selected w-6 h-6 mr-2"></div>
                    <span className="text-sm">Selected</span>
                  </div>
                  <div className="flex items-center">
                    <div className="seat seat-booked w-6 h-6 mr-2"></div>
                    <span className="text-sm">Booked</span>
                  </div>
                </div>
              </div>
              
              <div className="flex flex-col items-center">
                {rows.map(row => (
                  <div key={row} className="flex mb-2">
                    <div className="w-8 h-8 flex items-center justify-center mr-2 font-bold">
                      {row}
                    </div>
                    {[...Array(seatsPerRow)].map((_, index) => {
                      const seatNumber = index + 1;
                      const seatId = `${row}${seatNumber}`;
                      return (
                        <div 
                          key={seatId}
                          className={`seat ${
                            isSeatBooked(seatId) 
                              ? 'seat-booked' 
                              : isSeatSelected(seatId) 
                                ? 'seat-selected' 
                                : 'seat-available'
                          }`}
                          onClick={() => toggleSeat(seatId)}
                        >
                          {seatNumber}
                        </div>
                      );
                    })}
                    <div className="w-8 h-8 flex items-center justify-center ml-2 font-bold">
                      {row}
                    </div>
                  </div>
                ))}
              </div>
            </div>
            
            {/* Booking Summary */}
            <div className="bg-blue-950 p-6 rounded-lg">
              <h2 className="text-xl font-bold mb-4">Booking Summary</h2>
              
              <div className="space-y-2 mb-6">
                <div className="flex justify-between">
                  <span>Movie:</span>
                  <span className="font-medium">{movie.title}</span>
                </div>
                <div className="flex justify-between">
                  <span>Date & Time:</span>
                  <span className="font-medium">
                    {formatDate(showtime.show_date)}, {formatTime(showtime.show_time)}
                  </span>
                </div>
                <div className="flex justify-between">
                  <span>Theater:</span>
                  <span className="font-medium">{theater.name}</span>
                </div>
                <div className="flex justify-between">
                  <span>Selected Seats:</span>
                  <span className="font-medium">
                    {selectedSeats.length > 0 
                      ? selectedSeats.sort().join(", ") 
                      : "None selected"}
                  </span>
                </div>
              </div>
              
              <div className="border-t border-blue-800 pt-4">
                <div className="flex justify-between text-lg font-bold">
                  <span>Total Price:</span>
                  <span>${(selectedSeats.length * ticketPrice).toFixed(2)}</span>
                </div>
                <button 
                  onClick={handleBooking}
                  disabled={selectedSeats.length === 0}
                  className={`w-full mt-4 py-3 rounded-lg font-medium transition ${
                    selectedSeats.length > 0
                      ? 'bg-blue-600 hover:bg-blue-700 text-white'
                      : 'bg-blue-900 text-blue-300 cursor-not-allowed'
                  }`}
                >
                  {selectedSeats.length > 0 
                    ? `Book ${selectedSeats.length} Ticket${selectedSeats.length !== 1 ? 's' : ''}` 
                    : 'Select seats to continue'}
                </button>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  );
}

export default Booking;