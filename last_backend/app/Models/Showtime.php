<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Showtime extends Model
{
    //

    protected $fillable = [
        'movie_id',
        'theater_id',
        'show_date',
        'show_time'
    ];

    public function movie()
    {
        return $this->belongsTo(Movie::class, 'movie_id', 'id');
    }

    public function seats()
    {
        return $this->belongsToMany(Seat::class, 'showtime_seats', 'showtime_id', 'seat_id');
    }

    public function theater()
    {
        return $this->belongsTo(Theater::class, 'theater_id', 'id');
    }

    public function bookings()
    {
        return $this->hasMany(Booking::class);
    }

    
}
