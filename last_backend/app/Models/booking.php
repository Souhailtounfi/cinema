<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class booking extends Model
{
    protected $fillable = [
        'user_id',
        'showtime_id',
        'seat_id',
        'total_price',
    ];
    public function seat()
    {
        return $this->belongsTo(Seat::class, 'seat_id', 'seat_id');
    }


    public function showtime()
    {
        return $this->belongsTo(Showtime::class);
    }

}
