<?php

namespace App\Http\Controllers;


use App\Models\Showtime;
use App\Models\Movie;
use App\Models\Theater;
use Illuminate\Http\Request;
use Carbon\Carbon;
use App\Models\Seat;

class ShowtimeController extends Controller
{
    public function addShowtime(Request $request)
    {
        // Validate incoming request
        $request->validate([
            'movie_id' => 'required|exists:movies,id',
            'theater_id' => 'required|exists:theaters,id',
            'show_date' => 'required|date',
            'show_time' => 'required',
        ]);

        // Get the movie duration dyal lfilm li ajoutit b lforme
        $movie = Movie::where('id', $request->movie_id)->first();
        $movieDuration = $movie->duration_minutes; // b minutes

        // New show's start and end time  li ajoutina b lforme
        $newShowStart = Carbon::parse($request->show_time);//n7wl dateTime l int
        $newShowEnd = $newShowStart->copy()->addMinutes($movieDuration + 29); // 29 min buffer after movie ikhrjo nas tndm l9adia

        // Get existing showtimes for that day and theater f base d donne
        $existingShowtimes = Showtime::where('theater_id', $request->theater_id)
            ->where('show_date', $request->show_date)
            ->get();

        foreach ($existingShowtimes as $showtime) {
            $existingMovie = Movie::where('id', $showtime->movie_id)->first();
            $existingStart = Carbon::parse($showtime->show_time);
            $existingEnd = $existingStart->copy()->addMinutes($existingMovie->duration_minutes + 29);

            // Check if the new show overlaps with an existing one
            if (
                $newShowStart->between($existingStart, $existingEnd) ||
                $newShowEnd->between($existingStart, $existingEnd) ||
                ($existingStart->between($newShowStart, $newShowEnd))
            ) {
                return response()->json([
                    'message' => 'Cannot schedule movie at this time. Another movie is already showing in this theater.'
                ], 400);
            }
        }

        // If no conflict, create the showtime
        $showtime = Showtime::create([
            'movie_id' => $request->movie_id,
            'theater_id' => $request->theater_id,
            'show_date' => $request->show_date,
            'show_time' => $request->show_time,
        ]);

        return response()->json([
            'message' => 'Showtime added successfully!',
            'showtime' => $showtime
        ], 201);
    }

    public function getMovieShowtime($id)
    {
        $showtimes = Showtime::where('movie_id', $id)->get();

        if ($showtimes->isEmpty()) {
            return response()->json([
                'message' => 'No showtimes found for this movie.'
            ], 404);
        }

        $theaters = Theater::all()->keyBy('id');
        $movies = Movie::all()->keyBy('id');
        return response()->json(
            $showtimes->map(function ($showtime) use ($theaters, $movies) {
                return [
                    'showtime_id' => $showtime->id,
                    'movie_title' => $movies[$showtime->movie_id]->title ?? null,
                    'theater_name' => $theaters[$showtime->theater_id]->name ?? null,
                    'show_date' => $showtime->show_date,
                    'show_time' => $showtime->show_time,
                    'showtime_seats' => Seat::where('theater_id', $showtime->theater_id)->get()->map(function ($seat) {
                        return [
                            'seat_id' => $seat->seat_id,
                            'seat_number' => $seat->seat_number,
                        ];
                    }),
                ];
            })
        )->setStatusCode(200);
    }


}