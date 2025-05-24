<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Movie extends Model
{
    //

    protected $fillable = [
        'title',
        'description',
        'duration_minutes',
        'release_date',
        'poster_url',
        'trailer_url',
    ];

    public function showtimes()
    {
        return $this->hasMany(Showtime::class, 'movie_id');
    }
}
