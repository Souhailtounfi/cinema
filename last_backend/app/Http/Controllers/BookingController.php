<?php

namespace App\Http\Controllers;

use App\Models\Booking;
use App\Models\Seat;
use App\Models\Showtime;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class BookingController extends Controller
{
    // ✅ Return available seats (not booked yet)
    public function getBookedSeats(Showtime $showtime)
    {
        $showtime->load('theater');

        $bookedSeatIds = Booking::where('showtime_id', $showtime->id)
            ->pluck('seat_id');

        $availableSeats = Seat::where('theater_id', $showtime->theater_id)
            ->whereNotIn('seat_id', $bookedSeatIds)
            ->get()
            ->map(function ($seat) {
                return [
                    'seat_id' => $seat->seat_id,
                    'seat_number' => $seat->seat_number,
                ];
            });

        return response()->json([
            'available_seats' => $availableSeats
        ]);
    }

    // ✅ Book a single seat
    public function store(Request $request)
    {
        $validated = $request->validate([
            'user_id' => 'required|exists:users,id',
            'showtime_id' => 'required|exists:showtimes,id',
            'seat_id' => 'required|exists:seats,seat_id',
        ]);

        try {
            $booking = Booking::create([
                'user_id' => $validated['user_id'],
                'showtime_id' => $validated['showtime_id'],
                'seat_id' => $validated['seat_id'],
            ]);

            return response()->json([
                'booking_id' => $booking->id,
                'message' => 'Booking successful',
            ], 201);
        } catch (\Exception $e) {
            return response()->json([
                'message' => 'Booking failed: ' . $e->getMessage(),
            ], 500);
        }
    }

    // ✅ Get a specific booking
    public function show(Booking $booking)
    {
        $booking->load(['showtime.movie', 'showtime.theater', 'seat']);

        return response()->json([
            'booking_id' => $booking->id,
            'movie_title' => $booking->showtime->movie->title,
            'theater_name' => $booking->showtime->theater->name,
            'show_date' => $booking->showtime->show_date,
            'show_time' => $booking->showtime->show_time,
            'seat' => [
                'seat_row' => $booking->seat->seat_row ?? null,
                'seat_number' => $booking->seat->seat_number ?? null,
            ],
        ]);
    }
}
