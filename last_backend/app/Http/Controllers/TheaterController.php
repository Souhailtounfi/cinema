<?php

namespace App\Http\Controllers;

use App\Models\Theater;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;

class TheaterController extends Controller
{
    // List all theaters with their seats
    public function index()
    {
        $theaters = Theater::with('seats')->get();
        return response()->json($theaters);
    }

    // Store new theater with automatic seat generation max390 bach tji 15*26
    public function addTheater(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'name' => 'required|string|max:50|unique:theaters',
            'capacity' => 'required|integer|min:15|max:390'
        ]);

        if ($validator->fails()) {
            return response()->json([
                'status' => 'error',
                'errors' => $validator->errors()
            ], 422);
        }

        try {
            $theater = Theater::create($validator->validated());
            
            return response()->json([
                'status' => 'success',
                'message' => 'Theater created successfully with seats',
                'theater' => $theater->load('seats')
            ], 201);
            
        } catch (\Exception $e) {
            return response()->json([
                'status' => 'error',
                'message' => 'Failed to create theater',
                'error' => $e->getMessage()
            ], 500);
        }
    }

    // Get all theaters (basic info)
    public function getTheater()
    {
        return response()->json(Theater::all());
    }

    // Get theater names with IDs
    public function getTheaterName()
    {
        return response()->json(Theater::select('id', 'name')->get());
    }

    // Get specific theater with seats
    public function show($id)
    {
        $theater = Theater::with('seats', 'showtimes')->findOrFail($id);
        return response()->json($theater);
    }
}