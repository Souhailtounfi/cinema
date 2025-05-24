import React, { useEffect, useState } from "react";
import { useLocation, useParams } from "react-router-dom";
import axios from "axios";
import jsPDF from "jspdf";
import QRCode from "qrcode";
import { useAuth } from "../context/AuthContext";

const Booking = () => {
  const { user } = useAuth();
  const { id: showtimeId } = useParams();
  const location = useLocation();
  const { movie_title, date, time, theater, duration } = location.state || {};

  const [availableSeats, setAvailableSeats] = useState([]);
  const [selectedSeat, setSelectedSeat] = useState("");

  useEffect(() => {
    if (!showtimeId) return;

    axios
      .get(`http://localhost:8000/api/showtimes/${showtimeId}/booked-seats`)
      .then((res) => {
        // Expecting available_seats as an array of objects [{ seat_id, seat_number }, ...]
        setAvailableSeats(res.data.available_seats);
      })
      .catch(() => alert("Failed to fetch available seats"));
  }, [showtimeId]);

  const handleBook = async () => {
    if (!selectedSeat) {
      alert("Please select a seat.");
      return;
    }
    if (!user || !user.id) {
      alert("You must be logged in to book.");
      return;
    }

    const bookingDetails = {
      user_id: user.id,
      showtime_id: parseInt(showtimeId),
      seat_id: parseInt(selectedSeat),
    };

    try {
      // 1) Call API to store booking
      await axios.post("http://localhost:8000/api/bookings", bookingDetails);

      // 2) Generate PDF ticket
      const pdf = new jsPDF({
        orientation: "portrait",
        unit: "mm",
        format: [80, 120],
      });

      const seatNumber = availableSeats.find(
        (s) => s.seat_id === parseInt(selectedSeat)
      )?.seat_number;

      const qrData = JSON.stringify({
        user: user.name,
        movie: movie_title,
        theater,
        seat: seatNumber,
        date,
        time,
      });

      const qrUrl = await QRCode.toDataURL(qrData);
      pdf.addImage(qrUrl, "PNG", 10, 10, 30, 30);

      const text = `Booking Details

Name: ${user.name}
Movie: ${movie_title}
Theater: ${theater}
Seat: ${seatNumber}
Date: ${date}
Time: ${time}
Duration: ${duration} min
`;

      pdf.setFontSize(10);
      pdf.text(text, 10, 50);

      // 3) Trigger download
      pdf.save("ticket.pdf");

      alert("Booking successful! Your ticket has been downloaded.");
    } catch (error) {
      console.error(error);
      alert("Booking failed. Please try again.");
    }
  };

  if (!movie_title || !date || !time || !theater || !duration) {
    return (
      <div className="text-center mt-10 text-red-600">
        Booking details missing. Please go back and select a showtime.
      </div>
    );
  }

  return (
    <div className="flex justify-center items-center py-10 bg-gray-100 min-h-screen">
      <div className="bg-white p-8 shadow rounded-lg w-full max-w-md">
        <h3 className="text-center text-2xl font-bold mb-6">Book Your Seat</h3>
        <form
          className="space-y-4"
          onSubmit={(e) => {
            e.preventDefault();
            handleBook();
          }}
        >
          {user && (
            <input
              type="text"
              value={user.name}
              disabled
              className="w-full p-2 border rounded"
            />
          )}
          <input
            type="text"
            value={movie_title}
            disabled
            className="w-full p-2 border rounded bg-gray-100"
          />
          <input
            type="text"
            value={`${duration} min`}
            disabled
            className="w-full p-2 border rounded bg-gray-100"
          />
          <input
            type="text"
            value={theater}
            disabled
            className="w-full p-2 border rounded bg-gray-100"
          />
          <input
            type="text"
            value={`${date} at ${time}`}
            disabled
            className="w-full p-2 border rounded bg-gray-100"
          />

          <select
            value={selectedSeat}
            onChange={(e) => setSelectedSeat(e.target.value)}
            required
            className="w-full p-2 border rounded"
          >
            <option value="">Choose a seat</option>
            {availableSeats.map((seat) => (
              <option key={seat.seat_id} value={seat.seat_id}>
                {seat.seat_number}
              </option>
            ))}
          </select>

          <button
            type="submit"
            className="w-full bg-cyan-600 text-white py-2 rounded hover:bg-cyan-700"
          >
            Book & Download PDF
          </button>
        </form>
      </div>
    </div>
  );
};

export default Booking;
