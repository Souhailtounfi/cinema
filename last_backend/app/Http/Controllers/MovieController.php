<?php

namespace App\Http\Controllers;

use App\Models\Movie;
use Illuminate\Http\Request;

class MovieController extends Controller
{
    public function addMovie(Request $request)
    {

        $movie = Movie::create([
            'title' => $request->title,
            'description'=>$request->description,
            'duration_minutes'=>$request->duration,
            'release_date' => $request->release_date,
            'poster_url' => $request->poster_url,
        ]);

        
    }

    public function getMovies(){
        return response()->json(Movie::all());
    }
    public function getMovie($id){
        return Movie::find($id);
    }

    public function updateMovie(Request $request, $id)
    {
        $movie = Movie::findOrFail($id);
        $movie->update([
            'title' => $request->title,
            'description' => $request->description,
            'duration_minutes' => $request->duration,
            'release_date' => $request->release_date,
            'poster_url' => $request->poster_url,
        ]);

        return response()->json(['message' => 'Movie updated successfully']);
    }

    public function deleteMovie($id)
    {
        Movie::findOrFail($id)->delete();
        return response()->json(['message' => 'Movie deleted successfully']);
    }
}
