<?php

use App\Http\Controllers\ShowtimeController;
use App\Http\Controllers\TheaterController;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\UserController;
use App\Http\Controllers\MovieController;

Route::middleware('auth:sanctum')->group(function () {
Route::post('/logout', [UserController::class, 'logout']);
});

Route::post('/register', [UserController::class, 'register']);
Route::post('/login', [UserController::class, 'login']);


Route::middleware(['auth:sanctum'])->get('/user', function (Request $request) {
    return $request->user();
});

// Movies
Route::post('/addMovie', MovieController::class.'@addMovie');
Route::get('/movies', [MovieController::class, 'getMovies']);  // For fetching movie list
Route::get('/movies/{id}', [MovieController::class, 'getMovie']);
Route::put('/movies/{id}', [MovieController::class, 'updateMovie']);
Route::delete('/movies/{id}', [MovieController::class, 'deleteMovie']);



Route::post('/addShowtime', [ShowtimeController::class, 'addShowtime']);
//Route::get('/theaters', [TheaterController::class, 'getTheaters']); // For fetching theater list
Route::get('/getShowtimes/{id}', [ShowtimeController::class, 'getMovieShowtime']);


Route::post('/addTheater', [TheaterController::class, 'addTheater']);
Route::get('/getTheater', [TheaterController::class, 'getTheater']);
Route::get('/getTheaterName', [TheaterController::class, 'getTheaterName']);
// Route::put('/theaters/{id}', [TheaterController::class, 'update']);
// Route::delete('/theaters/{id}', [TheaterController::class, 'destroy']);


