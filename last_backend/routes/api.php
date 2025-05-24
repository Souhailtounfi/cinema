<?php

use App\Http\Controllers\ShowtimeController;
use App\Http\Controllers\TheaterController;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\UserController;
use App\Http\Controllers\MovieController;
use App\Http\Controllers\BookingController;

// Public routes
Route::post('/register', [UserController::class, 'register']);
Route::post('/login', [UserController::class, 'login']);

// Get movie list (public)
Route::get('/movies', [MovieController::class, 'getMovies']);
Route::get('/movies/{id}', [MovieController::class, 'getMovie']);

// Get showtimes (public)
Route::get('/getShowtimes/{id}', [ShowtimeController::class, 'getMovieShowtime']);
Route::get('/showtimes/{showtime}/booked-seats', [BookingController::class, 'getBookedSeats']);


// Get theaters (public)
Route::get('/getTheater', [TheaterController::class, 'getTheater']);
Route::get('/getTheaterName', [TheaterController::class, 'getTheaterName']);


Route::post('/bookings', [BookingController::class, 'store']);
// add showtime (public)
Route::post('/addShowtime', [ShowtimeController::class, 'addShowtime']);

// Authenticated routes (both users and admins)
Route::middleware('auth:sanctum')->group(function () {
    Route::post('/logout', [UserController::class, 'logout']);
    Route::get('/user', function (Request $request) {
        return $request->user();
    });
    
    // Booking routes
    Route::get('/bookings/{booking}', [BookingController::class, 'show']);
});

Route::put('/movies/{id}', [MovieController::class, 'updateMovie']);
Route::post('/addMovie', [MovieController::class, 'addMovie']);
Route::delete('/movies/{id}', [MovieController::class, 'deleteMovie']);
Route::post('/addTheater', [TheaterController::class, 'addTheater']);


// Admin-only routes
Route::middleware(['auth:sanctum', 'admin'])->group(function () {
    // Movie management
    
    // Showtime management
    
    // Theater management
    // Uncomment if needed:
    // Route::put('/theaters/{id}', [TheaterController::class, 'update']);
    // Route::delete('/theaters/{id}', [TheaterController::class, 'destroy']);
});